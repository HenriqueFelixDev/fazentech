import 'package:fazentech/app/exceptions/default_exception.dart';
import 'package:fazentech/app/shared/models/parameter_error_model.dart';

class InvalidParametersException extends DefaultException{
  List<ParameterErrorModel> errors;
  InvalidParametersException(
    String message, 
    this.errors,
    [int code = 400]
  ) : super(message);

  ParameterErrorModel getFieldError(String field) {
    final error = errors.firstWhere(
      (error) => error.param == field,
      orElse: () => null
    );

    return error;
  }
}