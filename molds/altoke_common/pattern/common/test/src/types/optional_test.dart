import 'package:altoke_common/common.dart';
import 'package:test/test.dart';

void main() {
  /*{% if use_overrides %}x*/
  group(Optional, () {
    group('some', () {
      test('| returns a present value', () {
        const subject = Optional.some('value');
        expect(subject, isA<Optional<String>>());
        expect(subject, isA<Some<String>>());
      });
    });

    group('none', () {
      test('| returns an absent value', () {
        const subject = Optional<String>.none();
        expect(subject, isA<Optional<String>>());
        expect(subject, isA<None<String>>());
      });
    });
  });

  group(Some, () {
    group('==', () {
      test('| returns true for the same value', () {
        const instance = Some('some-value');
        final subject = instance == const Some('some-value');
        expect(subject, isTrue);
      });

      test('| returns false for a different value', () {
        const instance = Some('some-value');
        final subject = instance == const Some('other-value');
        expect(subject, isFalse);
      });

      test('| returns false for another value type', () {
        const Object instance = Some('some-value');
        final subject = instance == const Some<int>(42);
        expect(subject, isFalse);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = Some<int>(1);
        final subject = instance == const Some<num>(1);
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = Some<num>(1);
        final subject = instance == const Some<int>(1);
        expect(subject, isFalse);
      });

      test('| returns false for an absent value', () {
        const Object instance = Some('some-value');
        final subject = instance == const None<double>();
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same value', () {
        const instance = Some('some-value');
        final subject = instance.hashCode;
        expect(subject, const Some('some-value').hashCode);
      });

      test('| does not match a different value', () {
        const instance = Some('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const Some('other-value').hashCode));
      });

      test('| does not match another value type', () {
        const instance = Some('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const Some<int>(42).hashCode));
      });

      test('| does not match a different type argument', () {
        const instance = Some<int>(1);
        final subject = instance.hashCode;
        expect(subject, isNot(const Some<num>(1).hashCode));
      });

      test('| does not match an absent value', () {
        const instance = Some('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const None<double>().hashCode));
      });
    });

    group('toString', () {
      test('| describes the present value', () {
        const instance = Some('some-value');
        final subject = instance.toString();
        expect(subject, 'Some<String>(value: some-value)');
      });
    });
  });

  group(None, () {
    group('==', () {
      test('| returns true for the same type', () {
        const instance = None<String>();
        final subject = instance == const None<String>();
        expect(subject, isTrue);
      });

      test('| returns true for another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = None<String>();
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final subject = instance == None<String>();
        expect(subject, isTrue);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = None<int>();
        final subject = instance == const None<num>();
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = None<num>();
        final subject = instance == const None<int>();
        expect(subject, isFalse);
      });

      test('| returns false for another type', () {
        const Object instance = None<String>();
        final subject = instance == const None<int>();
        expect(subject, isFalse);
      });

      test('| returns false for a present value', () {
        const Object instance = None<String>();
        final subject = instance == const Some<int>(42);
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same type', () {
        const instance = None<String>();
        final subject = instance.hashCode;
        expect(subject, const None<String>().hashCode);
      });

      test('| matches another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = None<String>();
        final subject = instance.hashCode;
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        expect(subject, None<String>().hashCode);
      });

      test('| does not match a different type argument', () {
        const instance = None<int>();
        final subject = instance.hashCode;
        expect(subject, isNot(const None<num>().hashCode));
      });

      test('| does not match another type', () {
        const instance = None<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const None<int>().hashCode));
      });

      test('| does not match a present value', () {
        const instance = None<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const Some<int>(42).hashCode));
      });
    });

    group('toString', () {
      test('| describes the absent value', () {
        const instance = None<String>();
        final subject = instance.toString();
        expect(subject, 'None<String>()');
      });
    });
  });
  /*x{% endif %}x*/
  /*x{% if use_equatable %}x*/
  group(EOptional, () {
    group('some', () {
      test('| returns a present value', () {
        const subject = EOptional.some('value');
        expect(subject, isA<EOptional<String>>());
        expect(subject, isA<ESome<String>>());
      });
    });

    group('none', () {
      test('| returns an absent value', () {
        const subject = EOptional<String>.none();
        expect(subject, isA<EOptional<String>>());
        expect(subject, isA<ENone<String>>());
      });
    });
  });

  group(ESome, () {
    group('==', () {
      test('| returns true for the same value', () {
        const instance = ESome('some-value');
        final subject = instance == const ESome('some-value');
        expect(subject, isTrue);
      });

      test('| returns false for a different value', () {
        const instance = ESome('some-value');
        final subject = instance == const ESome('other-value');
        expect(subject, isFalse);
      });

      test('| returns false for another value type', () {
        const Object instance = ESome('some-value');
        final subject = instance == const ESome<int>(42);
        expect(subject, isFalse);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = ESome<int>(1);
        final subject = instance == const ESome<num>(1);
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = ESome<num>(1);
        final subject = instance == const ESome<int>(1);
        expect(subject, isFalse);
      });

      test('| returns false for an absent value', () {
        const Object instance = ESome('some-value');
        final subject = instance == const ENone<double>();
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same value', () {
        const instance = ESome('some-value');
        final subject = instance.hashCode;
        expect(subject, const ESome('some-value').hashCode);
      });

      test('| does not match a different value', () {
        const instance = ESome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const ESome('other-value').hashCode));
      });

      test('| does not match another value type', () {
        const instance = ESome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const ESome<int>(42).hashCode));
      });

      test('| does not match a different type argument', () {
        const instance = ESome<int>(1);
        final subject = instance.hashCode;
        expect(subject, isNot(const ESome<num>(1).hashCode));
      });

      test('| does not match an absent value', () {
        const instance = ESome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const ENone<double>().hashCode));
      });
    });

    group('toString', () {
      test('| describes the present value', () {
        const instance = ESome('some-value');
        final subject = instance.toString();
        expect(subject, 'ESome<String>(value: some-value)');
      });
    });
  });

  group(ENone, () {
    group('==', () {
      test('| returns true for the same type', () {
        const instance = ENone<String>();
        final subject = instance == const ENone<String>();
        expect(subject, isTrue);
      });

      test('| returns true for another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = ENone<String>();
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final subject = instance == ENone<String>();
        expect(subject, isTrue);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = ENone<int>();
        final subject = instance == const ENone<num>();
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = ENone<num>();
        final subject = instance == const ENone<int>();
        expect(subject, isFalse);
      });

      test('| returns false for another type', () {
        const Object instance = ENone<String>();
        final subject = instance == const ENone<int>();
        expect(subject, isFalse);
      });

      test('| returns false for a present value', () {
        const Object instance = ENone<String>();
        final subject = instance == const ESome<int>(42);
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same type', () {
        const instance = ENone<String>();
        final subject = instance.hashCode;
        expect(subject, const ENone<String>().hashCode);
      });

      test('| matches another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = ENone<String>();
        final subject = instance.hashCode;
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        expect(subject, ENone<String>().hashCode);
      });

      test('| does not match a different type argument', () {
        const instance = ENone<int>();
        final subject = instance.hashCode;
        expect(subject, isNot(const ENone<num>().hashCode));
      });

      test('| does not match another type', () {
        const instance = ENone<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const ENone<int>().hashCode));
      });

      test('| does not match a present value', () {
        const instance = ENone<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const ESome<int>(42).hashCode));
      });
    });

    group('toString', () {
      test('| describes the absent value', () {
        const instance = ENone<String>();
        final subject = instance.toString();
        expect(subject, 'ENone<String>()');
      });
    });
  });
  /*x{% endif %}*/
}
