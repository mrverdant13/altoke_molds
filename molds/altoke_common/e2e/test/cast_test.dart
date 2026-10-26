@Tags(['e2e'])
library;

import 'dart:io';

import 'package:altoke_common/value_equality_approach.dart';
import 'package:coverage/coverage.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('cast', () {
    for (final approach in ValueEqualityApproach.values) {
      group(approach.id, () {
        test(
          '| formats, analyzes, tests, and covers the package',
          () => _expectCleanCast(approach),
          timeout: const Timeout(Duration(minutes: 5)),
        );

        test(
          '| writes only REQUIREMENTS.md when hooks are skipped',
          () => _expectRequirementsOnly(approach),
        );
      });
    }
  });

  group('sync', () {
    test('| leaves the template unchanged', _expectTemplateInSync);
  });
}

/// The mold directory. Tests run from `e2e/`, one level below it.
Directory get _moldDirectory => Directory.current.parent;

/// Repository root: `e2e/` → mold → `molds/` → root.
Directory get _repoRoot => _moldDirectory.parent.parent;

final _generatedFile = RegExp(r'\.(?:freezed|g|mapper)\.dart');

Future<void> _expectCleanCast(ValueEqualityApproach approach) async {
  final output = await _cast(approach);
  final package = Directory(p.join(output.path, 'common'));
  await _run('dart', ['format', '--set-exit-if-changed', '.'], package);
  await _run(
    'dart',
    ['analyze', '--fatal-infos', '--fatal-warnings', '.'],
    package,
  );
  final coverageDir = Directory(p.join(package.path, 'coverage'));
  await _run('dart', ['test', '--coverage=${coverageDir.path}'], package);
  await _expectFullCoverage(package, coverageDir);
}

Future<void> _expectRequirementsOnly(ValueEqualityApproach approach) async {
  final output = await _cast(approach, skipHooks: const ['shape', 'finish']);
  final names = <String>[];
  await for (final entity in output.list()) {
    names.add(p.basename(entity.path));
  }
  expect(names, ['REQUIREMENTS.md']);
}

Future<void> _expectTemplateInSync() async {
  await _run('foundry', ['mold', 'sync', '--pattern=pattern'], _moldDirectory);
  final status = await Process.run(
    'git',
    ['status', '--porcelain', '--', 'molds/altoke_common/template'],
    workingDirectory: _repoRoot.path,
  );
  expect(status.exitCode, 0);
  expect('${status.stdout}'.trim(), isEmpty, reason: '${status.stdout}');
}

Future<Directory> _cast(
  ValueEqualityApproach approach, {
  List<String> skipHooks = const [],
}) async {
  final output = await Directory.systemTemp.createTemp(
    'altoke-common-${approach.id}-',
  );
  addTearDown(() => output.delete(recursive: true));
  await _run(
    'foundry',
    [
      'cast',
      _moldDirectory.path,
      '--output=${output.path}',
      '--vars=${ValueEqualityApproach.variableKey}=${approach.id}',
      for (final phase in skipHooks) '--skip-hooks=$phase',
    ],
    _moldDirectory,
  );
  return output;
}

Future<void> _expectFullCoverage(
  Directory package,
  Directory coverageDir,
) async {
  final files = <File>[];
  await for (final entity in coverageDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.json')) {
      files.add(entity);
    }
  }
  expect(files, isNotEmpty);

  // `/tmp` is a symlink on macOS. Coverage file URIs use the resolved path,
  // and the resolver only keeps sources under [packagePath].
  final packagePath = await package.resolveSymbolicLinks();
  final hitmap = await HitMap.parseFiles(files, packagePath: packagePath);
  final resolver = await Resolver.create(packagePath: packagePath);
  final lcov = hitmap.formatLcov(
    resolver,
    basePath: packagePath,
    reportOn: [p.join(packagePath, 'lib')],
  );
  final filtered = _withoutGeneratedRecords(lcov);
  final missed = _missedLines(filtered);
  expect(missed, isEmpty, reason: 'Uncovered lines:\n${missed.join('\n')}');
  expect(
    filtered.split('\n').where((line) => line.startsWith('DA:')).length,
    greaterThan(0),
    reason: 'Coverage report has no library lines.',
  );
}

String _withoutGeneratedRecords(String lcov) {
  final kept = <String>[];
  for (final record in lcov.split('end_of_record\n')) {
    if (record.trim().isEmpty) {
      continue;
    }
    final source = RegExp(
      r'^SF:(.*)$',
      multiLine: true,
    ).firstMatch(record)?.group(1);
    if (source == null || _generatedFile.hasMatch(source)) {
      continue;
    }
    kept.add('${record}end_of_record\n');
  }
  return kept.join();
}

List<String> _missedLines(String lcov) {
  final missed = <String>[];
  var source = '';
  for (final line in lcov.split('\n')) {
    if (line.startsWith('SF:')) {
      source = line.substring('SF:'.length);
      continue;
    }
    if (!line.startsWith('DA:')) {
      continue;
    }
    final parts = line.substring('DA:'.length).split(',');
    if (parts.length != 2 || int.tryParse(parts[1]) != 0) {
      continue;
    }
    missed.add('$source:${parts[0]}');
  }
  return missed;
}

Future<void> _run(
  String executable,
  List<String> arguments,
  Directory workingDirectory,
) async {
  final ProcessResult result;
  try {
    result = await Process.run(
      executable,
      arguments,
      workingDirectory: workingDirectory.path,
    );
  } on ProcessException catch (error) {
    fail('Could not run $executable: $error');
  }
  if (result.exitCode == 0) {
    return;
  }
  final details = [
    result.stdout,
    result.stderr,
  ].map((output) => '$output'.trim()).where((output) => output.isNotEmpty);
  fail(
    [
      '$executable ${arguments.join(' ')}',
      'exited with ${result.exitCode}.',
      ...details,
    ].join('\n'),
  );
}
