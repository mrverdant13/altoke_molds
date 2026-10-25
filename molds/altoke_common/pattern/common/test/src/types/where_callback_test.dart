import 'package:altoke_common/common.dart';
import 'package:test/test.dart';

void main() {
  group('noFilter', () {
    test('| always returns true', () {
      final subject = noFilter(null);
      expect(subject, isTrue);
    });
  });

  group('noIndexedFilter', () {
    test('| always returns true', () {
      final subject = noIndexedFilter(null, null);
      expect(subject, isTrue);
    });
  });
}
