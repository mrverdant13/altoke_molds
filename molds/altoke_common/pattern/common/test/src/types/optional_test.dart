import 'package:altoke_common/common.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''
GIVEN a constructor for a present value
WHEN the constructor is called
THEN an instance of the present is returned
''',
    () {
      const presentValue = Optional.some('value');
      expect(presentValue, isNotNull);
      expect(presentValue, isA<Optional<String>>());
      expect(presentValue, isA<Some<String>>());
    },
  );

  test(
    '''
GIVEN a constructor for an absent value
WHEN the constructor is called
THEN an instance of the absent value is returned
''',
    () {
      const absentValue = Optional<String>.none();
      expect(absentValue, isNotNull);
      expect(absentValue, isA<Optional<String>>());
      expect(absentValue, isA<None<String>>());
    },
  );

  test(
    '''
GIVEN a couple of present values
WHEN they are directly compared
AND their hash codes are compared
THEN they are equal if they have the same values
AND their hash codes are equal if they have the same values
''',
    () {
      const presentValue = Optional.some('some-value');
      const sameOptional = Some('some-value');
      const differentOptional1 = Some('other-value');
      const differentOptional2 = Some<int>(42);
      const differentOptional3 = None<double>();
      expect(presentValue, sameOptional);
      expect(presentValue, isNot(differentOptional1));
      expect(presentValue, isNot(differentOptional2));
      expect(presentValue, isNot(differentOptional3));
      expect(presentValue.hashCode, sameOptional.hashCode);
      expect(presentValue.hashCode, isNot(differentOptional1.hashCode));
      expect(presentValue.hashCode, isNot(differentOptional2.hashCode));
      expect(presentValue.hashCode, isNot(differentOptional3.hashCode));
    },
  );

  test(
    '''
GIVEN a couple of absent values
WHEN they are directly compared
AND their hash codes are compared
THEN they are equal if they have the same values
AND their hash codes are equal if they have the same values
''',
    () {
      const absentValue = Optional<String>.none();
      const sameOptional = None<String>();
      const differentOptional1 = None<int>();
      const differentOptional2 = None<double>();
      const differentOptional3 = Some<int>(42);
      expect(absentValue, sameOptional);
      expect(absentValue, isNot(differentOptional1));
      expect(absentValue, isNot(differentOptional2));
      expect(absentValue, isNot(differentOptional3));
      expect(absentValue.hashCode, sameOptional.hashCode);
      expect(absentValue.hashCode, isNot(differentOptional1.hashCode));
      expect(absentValue.hashCode, isNot(differentOptional2.hashCode));
      expect(absentValue.hashCode, isNot(differentOptional3.hashCode));
    },
  );

  test(
    '''
GIVEN a present value
WHEN its string representation is requested
THEN a string representation of the present value is returned
''',
    () {
      const presentValue = Optional.some('some-value');
      expect(presentValue.toString(), 'Some<String>(value: some-value)');
    },
  );

  test(
    '''
GIVEN an absent value
WHEN its string representation is requested
THEN a string representation of the absent value is returned
''',
    () {
      const absentValue = Optional<String>.none();
      expect(absentValue.toString(), 'None<String>()');
    },
  );
}
