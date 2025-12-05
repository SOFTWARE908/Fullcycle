
extension StringExtenstions on String {
  emailValidator(String? value) {
    const String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'البريد الالكتروني مطلوب';
    } else if (!regex.hasMatch(value)) {
      return 'ادخل بريد الكتروني صحيح';
    } else {
      return null;
    }
  }

  phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'ادخل رقم الهاتف';
    }
    if (value.length < 10) {
      return 'ادخل رقم هاتف صحيح';
    } else {
      return null;
    }
  }

  String? idValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "رقم البطاقة مطلوب";
    } else if (value.length != 10) {
      return 'رقم البطاقة يجب أن يحتوي علي ١٠ احرف';
    } else {
      return null;
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'name is required';
    } else if (value.length < 2) {
      return 'name must be at least 2 characters';
    } else {
      return null;
    }
  }

  String? linkValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرابط مطلوب';
    } else if (value.length < 10 || value.contains(' ')) {
      return 'الرابط غير صحيح';
    } else {
      return null;
    }
  }

  String? cardValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهوية مطلوب';
    } else if (value.length < 10) {
      return 'ادخل رقم الهوية بشكل صحيح';
    } else {
      return null;
    }
  }

  String? passwordValidator(String? value) {
    const String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$';
    final RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'password is required';
    } else if (!regex.hasMatch(value)) {
      return 'password must be at least 8 characters, include letters and numbers';
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'confirm password is required';
    }
    if (value != password) {
      return 'passwords do not match';
    }
    return null;
  }
}
