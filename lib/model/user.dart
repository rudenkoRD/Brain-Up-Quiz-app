import 'package:schoollearning/model/quiz/quiz.dart';
import 'package:schoollearning/model/user_data.dart';

class AppUser {
  String _username;
  String _email;
  String _password;
  String _uid;
  UserData _userData = UserData();

  String get username => _username;
  String get email => _email;
  String get uid => _uid;
  String get password => _password;
  UserData get userData => _userData;

  set username(newValue) => _username = newValue;
  set email(newValue) => _email = newValue;
  set featuredQuizId(newValue) => _userData = newValue;
  set uid(newValue) => _uid = newValue;
  set userData(newValue) => _userData = newValue;
  set password(newValue) => _password = newValue;

  AppUser();
}
