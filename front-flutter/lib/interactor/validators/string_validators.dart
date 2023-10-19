import 'package:csm_front/core/constants.dart';

mixin StringValidatorsMixin {
  String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? isValidEmail(String? value) {
    if (!RegExp(kEmailRegExp).hasMatch(value!)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? isValidPassword(String? value) {
    if (value!.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  String? combine(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final error = validator.call(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
