abstract class MInputValidator<T> {
  String? validate(T? value);

  // ignore: unused_field
  abstract final String _errorMessage;
}

class NotNullValidator<T> extends MInputValidator<T> {
  @override
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  @override
  String? validate(value) {
    var x = (value == null) ? errorMessage : null;
    return x;
  }

  NotNullValidator() : _errorMessage = "Polje je obvezno";

  NotNullValidator.withCustomMessage(this._errorMessage);
}

class NotEmptyValidator extends NotNullValidator<String> {
  @override
  String? validate(value) =>
      (value == null || value.isEmpty) ? errorMessage : null;

  NotEmptyValidator() : super();

  NotEmptyValidator.withCustomMessage(String message)
      : super.withCustomMessage(message);
}

class MinLengthValidator extends MInputValidator<String> {
  @override
  final String _errorMessage;

  final int minLength;

  MinLengthValidator(this.minLength)
      : _errorMessage = "Minimalna dolžina vnosa je $minLength";

  MinLengthValidator.withCustomMessage({
    required this.minLength,
    required String errorMessage,
  }) : _errorMessage = errorMessage;

  String get errorMessage => _errorMessage;

  @override
  String? validate(value) {
    var notNull = value == null;
    var l = value!.length < minLength;
    var c = notNull || l;
    var x = value == null || value.length < minLength ? errorMessage : null;
    return x;
  }
}

class MaxLengthValidator extends MInputValidator<String> {
  @override
  final String _errorMessage;

  final int maxLength;

  MaxLengthValidator(this.maxLength)
      : _errorMessage = "Maksimalna dolžina vnosa je $maxLength";

  MaxLengthValidator.withCustomMessage({
    required this.maxLength,
    required String errorMessage,
  }) : _errorMessage = errorMessage;

  String get errorMessage => _errorMessage;

  @override
  String? validate(value) =>
      value == null || value.length > maxLength ? errorMessage : null;
}

class EmailValidator extends MInputValidator<String> {
  @override
  final String _errorMessage;

  EmailValidator() : _errorMessage = "Vnos ni veljaven email naslov";

  EmailValidator.withCustomMessage(this._errorMessage);

  String get errorMessage => _errorMessage;

  @override
  String? validate(value) => value != null &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)
      ? null
      : errorMessage;
}

class CustomValidator<T> extends MInputValidator<T> {
  @override
  final String _errorMessage;
  final bool Function(T?) _callableFunction;

  @override
  String? validate(T? value) {
    return _callableFunction(value) ? null : errorMessage;
  }

  CustomValidator(String errorMessage, bool Function(T?) validate)
      : _callableFunction = validate,
        _errorMessage = errorMessage;

  String get errorMessage => _errorMessage;
}
