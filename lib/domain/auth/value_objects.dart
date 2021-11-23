import 'package:dartz/dartz.dart';
import 'package:ddd/domain/core/failures.dart';
import 'package:ddd/domain/core/value_objects.dart';
import 'package:ddd/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  // final Either<Left, Right>
  //     failure; //explained below why we have union type in failure propert.

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }
  // thats how we are validating email address at the time of instantiation by
  // creating this factory constructor over normal constructor which have power of
  // returning an instance of another class to as a constructor also in normal constructor
  // we dont have option to return something that how we have taken factory constructor in use to
  // making illegal states unrepresentable.

  const EmailAddress._(
    this.value,
  ) : assert(value != null);

// value equality for string value
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailAddress && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

// Some classes have a default textual representation, often paired with a static parse function (like int. parse). ... Such classes will typically override toString to provide useful information when inspecting the object, mainly for debugging or logging.
  @override
  String toString() => 'EmailAddress(value: $value)';
}

//if we have builder package this annotation will give error

// abstract class Failure {
// } //explained below why we have an abstract class for all types of failures.

// class InvalidEmailFailure implements Failure {
//   final String? failedValue;
//   InvalidEmailFailure({@required this.failedValue});
// }

// // void insideTheUI(EmailAddress emailAddress) {
// //   if (emailAddress.failure == null) {
// //     emailAddress.value;

// //   } else {
// //     // Error Snackbar
// //   }
// // }

// class InvalidPasswordFailure implements Failure {
//   final String? failedValue;
//   InvalidPasswordFailure({@required this.failedValue});

// we now have two failures but they are not related in any sort of way if
// we wanted to check through all of the possible failures which can be thrown
// from some method we would again or not but returned from a method we would again need
//to rely on our brains to remember which kind of failures can be returned from a particular method
//in other words we would be in no better place than if we just throw exceptions also we will have an abstract class for
//all these failures we would be able to return both of these failures under their super type but again we would need to remeber about
// all of the subtypes of failure in our head so again even for these failures we are going to create union type and this
// and this way we wont need to remember what kind of failures we have in our app by
//ourselves instead the union type will tell us.

// void showingTheEmailAddressOrFailure() {
//   final emailAddress = EmailAddress('asaasas');
//   String emailText = emailAddress.value.fold(
//       (left) => 'Failure happened, more precisely: $left', (right) => right);
// }

// String emailText2 =
//     emailAddress.value.getOrElse(() => 'Some  Failure Happened');

class Password extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  // final Either<Left, Right>
  //     failure; //explained below why we have union type in failure propert.

  factory Password(String input) {
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(
    this.value,
  ) : assert(value != null);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Password && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Password(value: $value)';
}
