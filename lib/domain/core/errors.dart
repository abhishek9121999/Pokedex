import 'package:ddd/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;
  UnexpectedValueError(this.valueFailure);
}
