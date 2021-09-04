

class TextValidator{
  String _emailValidationPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  String _passwordValidationPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';

  String validatePassword(value){
    if (value.trim().isEmpty)
      return "Password is required";

    if (value.trim().length < 8)
      return "your password must have at least 8 characters";

    if (!RegExp(_passwordValidationPattern).hasMatch(value))
      return 'password is too weak, use numbers, lower and upper case';

    return null;
  }

  String validateEmail(value){
    if (value.trim().isEmpty)
      return 'email is required';

    if (!RegExp(_emailValidationPattern).hasMatch(value))
      return 'your email isn\'t valid';

    return null;
  }

  String checkIfEmptyPassword(value){
    if (value.trim().isEmpty)
      return 'Password is required';

    return null;
  }

  String validateUserName(value){
    if (value.trim().isEmpty) {
      return 'username is required';
    }
    return null;
  }
}