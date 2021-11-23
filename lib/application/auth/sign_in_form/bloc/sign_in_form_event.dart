part of 'sign_in_form_bloc.dart';

@freezed // using freezed annotation import from sign_in_form_bloc becuase this file is part of that file and cant import packages
abstract class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String emailStr) = _EmailChanged;
  const factory SignInFormEvent.passwordChanged(String passwordStr) =
      _PasswordChanged;
  const factory SignInFormEvent.registerWithEmailAndPasswordPressed() =
      RegisterWithEmailAndPasswordPressed;
  const factory SignInFormEvent.signInWithEmailAndPasswordPressed() =
      SignInWithEmailAndPasswordPressed;
  const factory SignInFormEvent.signInWithGooglePressed() =
      _SignInWithGooglePressed;
}
