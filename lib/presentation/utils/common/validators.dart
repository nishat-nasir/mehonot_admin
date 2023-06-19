import '../../template/template.dart';

class Validator {
  final BuildContext context;

  Validator(this.context);

  String? validatePassword(String? value) {
    if (value != null && value.isEmpty) {
      return S(context).pwdCanNotEmpty;
    } else {
      final passwordRegExp = RegExp(
          r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$");
      if (passwordRegExp.hasMatch(value ?? "")) {
        return null;
      } else {
        return "${S(context).pwdShouldContain} & (1-0, a-z, A-Z, !@#\$%^&*()_+)";
      }
    }
  }

  String? validateNumber(String? value) {
    if (value != null && value.isEmpty) {
      return S(context).fieldCanNotEmpty;
    } else {
      if (double.parse(value!) <= 0) {
        return S(context).numCanNotZeroNeg;
      }
      return null;
    }
  }

  String? validateEmail(String? value) {
    const pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';

    RegExp regExp = RegExp(pattern);
    if (value != null && value.isEmpty) {
      return S(context).emailCanNotEmpty;
    } else if (value != null && !regExp.hasMatch(value)) {
      return S(context).invalidEmail;
    }
    return null;
  }

  String? validateWebsite(String? value) {
    const pattern = r'^(http(s)?:\/\/)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)?$';

    RegExp regExp = RegExp(pattern);
    if (value != null && value.trim().isEmpty) {
      return null; // Return null if the value is empty or blank
    } else if (value != null && !regExp.hasMatch(value)) {
      return 'Invalid website link';
    }
    return null;
  }

  String? validateField(String? value) {
    if (value != null && value.isEmpty) {
      return S(context).fieldCanNotEmpty;
    } else {
      return null;
    }
  }

  String? validatePhone(String? value) {
    const pattern = r'^(\+88|01)?\d{11}$';

    RegExp regExp = RegExp(pattern);
    if (value != null && value.isEmpty) {
      return S(context).phoneCanNotEmpty;
    } else if (value != null && !regExp.hasMatch(value)) {
      return S(context).invalidPhone;
    }
    return null;
  }

  String? validateOnlyWords(String? value) {
    const pattern = r'^[a-zA-Z ]+$';

    RegExp regExp = RegExp(pattern);
    if (value != null && value.isEmpty) {
      return S(context).fieldCanNotEmpty;
    } else if (value != null && !regExp.hasMatch(value)) {
      return S(context).invalidName;
    }
    return null;
  }

  String? validateTime(String? value) {
    if (value != null && value.isEmpty) {
      return S(context).fieldCanNotEmpty;
    } else {
      if (int.parse(value!) <= 0) {
        return S(context).numCanNotZeroNeg;
      }
      if (value.length != 4) {
        return "Time Format is 0900";
      }
      String hour = value.substring(0, 2);
      int intH = int.parse(hour);
      String min = value.substring(2, 4);
      int intM = int.parse(min);
      if (intH > 23 || intM > 59) {
        return "Time range 0000 ~ 2359";
      }
      return null;
    }
  }

  String? validateyyyymmdd(String? value) {
    if (value != null && value.isEmpty) {
      return S(context).fieldCanNotEmpty;
    } else {
      if (int.parse(value!) <= 0) {
        return S(context).numCanNotZeroNeg;
      }
      if (value.length != 8) {
        return "Date Format is yyyyMMdd";
      }
      String yyyy = value.substring(0, 4);
      int intY = int.parse(yyyy);

      String mm = value.substring(4, 6);
      int intM = int.parse(mm);

      String dd = value.substring(6, 8);
      int intD = int.parse(dd);

      if (intY > 2031 || intY < 2021 || intM > 12 || intD > 31) {
        return "Date range 20210101 ~ 20301230";
      }
      return null;
    }
  }
}
