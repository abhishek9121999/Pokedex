// Facade is a design pattern which is used for connectoing two or more classes which have wierd interfaces and you can not use those interfaces in your app and
// facade takes those multiple classes and plug them into a nice and unified interface

import 'package:dartz/dartz.dart';
import 'package:ddd/domain/auth/auth_failure.dart';
import 'package:ddd/domain/auth/value_objects.dart';
import 'package:flutter/foundation.dart';

// FirebaseAuth,

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    // we are using unit here not void beacuse in dart void is not a class its just a simple keyword
    @required EmailAddress emailAddress,
    @required Password password,
  });
// So these either dont return any value or they return failure.
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<Either<AuthFailure, String>> returnsAValueString();
}

// if you take a look at the diagram in the infrastructure layer for
// which we have currently created an interface there are only repositories
//there is no word about facades however facades are on the same level as repositories
//they still deal with raw data from data sources in our case when we implement
//this I off facade using firebase butin addition to the repositories they also have
// the role of simplifying interface of the contained classes thats becasue as i already said
//in the beginning once we start implementing this interface here its going to depend on firebase off
// and also on google sign-in classes and so tnat we do not need to depend on multiple
// classes inside the application layer we are just going to simplify the interface of two classes
// into just one class using IAuthFacade thats te role of facade.
//
