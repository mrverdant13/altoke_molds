import 'package:common/common.dart';
import 'package:test/test.dart';

void main() {
  {% if use_overrides %}group(Optional, () {
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
  });{% endif %}{% if use_equatable %}group(Optional, () {
    group('some', () {
      test('| returns a present value', () {
        const subject = Optional.some('value');
        expect(subject, isA<Optional<String>>());
        expect(subject, isA<ESome<String>>());
      });
    });

    group('none', () {
      test('| returns an absent value', () {
        const subject = Optional<String>.none();
        expect(subject, isA<Optional<String>>());
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
  });{% endif %}{% if use_dart_mappable %}group(Optional, () {
    group('some', () {
      test('| returns a present value', () {
        const subject = Optional.some('value');
        expect(subject, isA<Optional<String>>());
        expect(subject, isA<DmSome<String>>());
      });
    });

    group('none', () {
      test('| returns an absent value', () {
        const subject = Optional<String>.none();
        expect(subject, isA<Optional<String>>());
        expect(subject, isA<DmNone<String>>());
      });
    });
  });

  group(DmSome, () {
    group('==', () {
      test('| returns true for the same value', () {
        const instance = DmSome('some-value');
        final subject = instance == const DmSome('some-value');
        expect(subject, isTrue);
      });

      test('| returns false for a different value', () {
        const instance = DmSome('some-value');
        final subject = instance == const DmSome('other-value');
        expect(subject, isFalse);
      });

      test('| returns false for another value type', () {
        const Object instance = DmSome('some-value');
        final subject = instance == const DmSome<int>(42);
        expect(subject, isFalse);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = DmSome<int>(1);
        final subject = instance == const DmSome<num>(1);
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = DmSome<num>(1);
        final subject = instance == const DmSome<int>(1);
        expect(subject, isFalse);
      });

      test('| returns false for an absent value', () {
        const Object instance = DmSome('some-value');
        final subject = instance == const DmNone<double>();
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same value', () {
        const instance = DmSome('some-value');
        final subject = instance.hashCode;
        expect(subject, const DmSome('some-value').hashCode);
      });

      test('| does not match a different value', () {
        const instance = DmSome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const DmSome('other-value').hashCode));
      });

      test('| does not match another value type', () {
        const instance = DmSome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const DmSome<int>(42).hashCode));
      });

      test('| does not match a different type argument', () {
        const instance = DmSome<int>(1);
        final subject = instance.hashCode;
        expect(subject, isNot(const DmSome<num>(1).hashCode));
      });

      test('| does not match an absent value', () {
        const instance = DmSome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const DmNone<double>().hashCode));
      });
    });

    group('toString', () {
      test('| describes the present value', () {
        const instance = DmSome('some-value');
        final subject = instance.toString();
        expect(subject, 'DmSome(value: some-value)');
      });
    });
  });

  group(DmNone, () {
    group('==', () {
      test('| returns true for the same type', () {
        const instance = DmNone<String>();
        final subject = instance == const DmNone<String>();
        expect(subject, isTrue);
      });

      test('| returns true for another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = DmNone<String>();
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final subject = instance == DmNone<String>();
        expect(subject, isTrue);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = DmNone<int>();
        final subject = instance == const DmNone<num>();
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = DmNone<num>();
        final subject = instance == const DmNone<int>();
        expect(subject, isFalse);
      });

      test('| returns false for another type', () {
        const Object instance = DmNone<String>();
        final subject = instance == const DmNone<int>();
        expect(subject, isFalse);
      });

      test('| returns false for a present value', () {
        const Object instance = DmNone<String>();
        final subject = instance == const DmSome<int>(42);
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same type', () {
        const instance = DmNone<String>();
        final subject = instance.hashCode;
        expect(subject, const DmNone<String>().hashCode);
      });

      test('| matches another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = DmNone<String>();
        final subject = instance.hashCode;
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        expect(subject, DmNone<String>().hashCode);
      });

      test('| does not match a different type argument', () {
        const instance = DmNone<int>();
        final subject = instance.hashCode;
        expect(subject, isNot(const DmNone<num>().hashCode));
      });

      test('| does not match another type', () {
        const instance = DmNone<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const DmNone<int>().hashCode));
      });

      test('| does not match a present value', () {
        const instance = DmNone<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const DmSome<int>(42).hashCode));
      });
    });

    group('toString', () {
      test('| describes the absent value', () {
        const instance = DmNone<String>();
        final subject = instance.toString();
        expect(subject, 'DmNone()');
      });
    });
  });{% endif %}{% if use_freezed %}group(Optional, () {
    group('some', () {
      test('| returns a present value', () {
        const subject = Optional.some('value');
        expect(subject, isA<Optional<String>>());
        expect(subject, isA<FSome<String>>());
      });
    });

    group('none', () {
      test('| returns an absent value', () {
        const subject = Optional<String>.none();
        expect(subject, isA<Optional<String>>());
        expect(subject, isA<FNone<String>>());
      });
    });
  });

  group(FSome, () {
    group('==', () {
      test('| returns true for the same value', () {
        const instance = FSome('some-value');
        final subject = instance == const FSome('some-value');
        expect(subject, isTrue);
      });

      test('| returns false for a different value', () {
        const instance = FSome('some-value');
        final subject = instance == const FSome('other-value');
        expect(subject, isFalse);
      });

      test('| returns false for another value type', () {
        const Object instance = FSome('some-value');
        final subject = instance == const FSome<int>(42);
        expect(subject, isFalse);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = FSome<int>(1);
        final subject = instance == const FSome<num>(1);
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = FSome<num>(1);
        final subject = instance == const FSome<int>(1);
        expect(subject, isFalse);
      });

      test('| returns false for an absent value', () {
        const Object instance = FSome('some-value');
        final subject = instance == const FNone<double>();
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same value', () {
        const instance = FSome('some-value');
        final subject = instance.hashCode;
        expect(subject, const FSome('some-value').hashCode);
      });

      test('| does not match a different value', () {
        const instance = FSome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const FSome('other-value').hashCode));
      });

      test('| does not match another value type', () {
        const instance = FSome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const FSome<int>(42).hashCode));
      });

      test('| does not match a different type argument', () {
        const instance = FSome<int>(1);
        final subject = instance.hashCode;
        expect(subject, isNot(const FSome<num>(1).hashCode));
      });

      test('| does not match an absent value', () {
        const instance = FSome('some-value');
        final subject = instance.hashCode;
        expect(subject, isNot(const FNone<double>().hashCode));
      });
    });

    group('toString', () {
      test('| describes the present value', () {
        const instance = FSome('some-value');
        final subject = instance.toString();
        expect(subject, 'Optional<String>.some(value: some-value)');
      });
    });
  });

  group(FNone, () {
    group('==', () {
      test('| returns true for the same type', () {
        const instance = FNone<String>();
        final subject = instance == const FNone<String>();
        expect(subject, isTrue);
      });

      test('| returns true for another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = FNone<String>();
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final subject = instance == FNone<String>();
        expect(subject, isTrue);
      });

      test('| returns false for a supertype argument', () {
        const Object instance = FNone<int>();
        final subject = instance == const FNone<num>();
        expect(subject, isFalse);
      });

      test('| returns false for a subtype argument', () {
        const Object instance = FNone<num>();
        final subject = instance == const FNone<int>();
        expect(subject, isFalse);
      });

      test('| returns false for another type', () {
        const Object instance = FNone<String>();
        final subject = instance == const FNone<int>();
        expect(subject, isFalse);
      });

      test('| returns false for a present value', () {
        const Object instance = FNone<String>();
        final subject = instance == const FSome<int>(42);
        expect(subject, isFalse);
      });
    });

    group('hashCode', () {
      test('| matches the same type', () {
        const instance = FNone<String>();
        final subject = instance.hashCode;
        expect(subject, const FNone<String>().hashCode);
      });

      test('| matches another instance', () {
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        final instance = FNone<String>();
        final subject = instance.hashCode;
        // Distinct instances: a const call would canonicalize them.
        // ignore: prefer_const_constructors
        expect(subject, FNone<String>().hashCode);
      });

      test('| does not match a different type argument', () {
        const instance = FNone<int>();
        final subject = instance.hashCode;
        expect(subject, isNot(const FNone<num>().hashCode));
      });

      test('| does not match another type', () {
        const instance = FNone<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const FNone<int>().hashCode));
      });

      test('| does not match a present value', () {
        const instance = FNone<String>();
        final subject = instance.hashCode;
        expect(subject, isNot(const FSome<int>(42).hashCode));
      });
    });

    group('toString', () {
      test('| describes the absent value', () {
        const instance = FNone<String>();
        final subject = instance.toString();
        expect(subject, 'Optional<String>.none()');
      });
    });
  });{% endif %}
}
