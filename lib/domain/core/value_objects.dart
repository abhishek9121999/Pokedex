// // core folder holds something which is common to mutiple features of our app
// import 'package:dartz/dartz.dart';
// import 'package:ddd/domain/core/failures.dart';
// import 'package:ddd/domain/core/value_validators.dart';

// class EmailAddress extends ValueObject<String> {
//   // Already implemented
// }

// class Password extends ValueObject<String> {
//   @override
//   final Either<ValueFailure<String>, String> value;

//   factory Password(String input) {
//     assert(input != null);
//     return Password._(
//       validatePassword(input),
//     );
//   }

//   const Password._(this.value);
// }

import 'package:dartz/dartz.dart';
import 'package:ddd/domain/auth/email_address.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  // final Either<Left, Right>
  //     failure; //explained below why we have union type in failure propert.

  // factory EmailAddress(String input) {
  //   assert(input != null);
  //   return EmailAddress._(
  //     validateEmailAddress(input),
  //   );
  // }
  // thats how we are validating email address at the time of instantiation by
  // creating this factory constructor over normal constructor which have power of
  // returning an instance of another class to as a constructor also in normal constructor
  // we dont have option to return something that how we have taken factory constructor in use to
  // making illegal states unrepresentable.

  // const EmailAddress._(
  //   this.value,
  // ) : assert(value != null);

// value equality for string value
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

// Some classes have a default textual representation, often paired with a static parse function (like int. parse). ... Such classes will typically override toString to provide useful information when inspecting the object, mainly for debugging or logging.
  @override
  String toString() => 'Value(value: $value)';
}
