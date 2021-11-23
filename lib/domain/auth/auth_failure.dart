// Possible failures here

// 1.User "taps out" of the 3rd party sign-in flow (Google in our case)
// 2.There is an error on the auth server.
// 3.User wants to register with an email which is already in use.
// 4.User enters an invalid combination of email and password.

import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cancelledByUser() = CancelledByUser;
  const factory AuthFailure.serverError() = ServerError;
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      InvalidEmailAndPasswordCombination;
}
