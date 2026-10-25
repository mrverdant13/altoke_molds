import 'dart:io';

import 'package:foundry_core/foundry_core.dart';

/// Installs dependencies, generates code, fixes directive order, and formats.
Future<void> run(FoundryContext context) async {
  final packageDir = Directory(
    '${context.outputDirectory.path}${Platform.pathSeparator}common',
  );
  await _run(context, packageDir, ['pub', 'get'], 'Installing dependencies');
  if (context.optionalBool('use_code_generation') ?? false) {
    await _run(
      context,
      packageDir,
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      'Running code generation',
    );
  }
  await _run(
    context,
    packageDir,
    ['fix', '--apply', '--code=directives_ordering'],
    'Applying fixes',
  );
  await _run(context, packageDir, ['format', '.'], 'Formatting code');
}

Future<void> _run(
  FoundryContext context,
  Directory workingDirectory,
  List<String> arguments,
  String message,
) async {
  final progress = context.logger.progress(message);
  final result = await Process.run(
    'dart',
    arguments,
    workingDirectory: workingDirectory.path,
  );
  if (result.exitCode != 0) {
    progress.fail();
    final details = [result.stdout, result.stderr]
        .map((output) => '$output'.trim())
        .where((output) => output.isNotEmpty);
    throw FoundryHookException(
      [
        'Failed to run dart ${arguments.join(' ')}.',
        ...details,
      ].join('\n'),
    );
  }
  progress.complete();
}
