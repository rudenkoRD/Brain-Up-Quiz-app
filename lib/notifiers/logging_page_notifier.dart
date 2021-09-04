import 'package:flutter/cupertino.dart';

class LoggingPageNotifier with ChangeNotifier{
  LoggingPageType _currentPage = LoggingPageType.LOGIN;

  get currentPage => _currentPage;
  set currentPage(value) {
    _currentPage = value;
    notifyListeners();
  }

}

enum LoggingPageType { LOGIN, SIGNUP }