// its under the infrastructure because we are gonna be dealing with third party
//dependencies and the reason why interface i_auth_facade is in the domain layer
// is becuase the interface is completely independent of any third-party dependencies
//it just defines a contract and that contact should be fullfilled no matter if we use firebase
//or some custom authentication solution this facede contact needs to be full filled
//thats why its in domain but as soon as we start even with the specificities of firebase we need
// to move over the infrastrcuture later.

import 'package:ddd/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd/domain/auth/i_auth_facade.dart';
import 'package:ddd/domain/auth/value_objects.dart';
import 'package:ddd/domain/core/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth; //its the dependency field name.
  final GoogleSignIn _googleSignIn;
  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress? emailAddress,
    @required Password? password,
  }) async {
    final emailAddressStr = emailAddress!.getOrCrash();
    final passwordStr = password!.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress? emailAddress,
    @required Password? password,
  }) async {
    final emailAddressStr = emailAddress!.getOrCrash();
    final passwordStr = password!.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUser;

      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );
      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((r) => right(unit));
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }
}
