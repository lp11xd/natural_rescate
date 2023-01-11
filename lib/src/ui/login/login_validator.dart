class FormValidator {
  static FormValidator _instance;

  factory FormValidator() => _instance ??= new FormValidator._();

  FormValidator._();

  String validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Contraseña es obligatorio.";
    } else if (value.length < 5) {
      return "Password must minimum eight characters";
    } else if (!regExp.hasMatch(value)) {
      return "Password at least one uppercase letter, one lowercase letter and one number";
    }
    return null;
  }

  String validateField(String value) {
    if (value.isEmpty) {
      return "Este campo es obligatorio";
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Este campo es obligatorio";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
}
