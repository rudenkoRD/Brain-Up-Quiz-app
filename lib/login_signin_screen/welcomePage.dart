import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/login_signin_screen/login_screen/login_screen.dart';
import 'package:schoollearning/login_signin_screen/sign_up_screen/sign_up_sreen.dart';
import 'package:schoollearning/notifier/logging_page_notifier.dart';


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  LoggingPageNotifier loggingPageNotifier;

  @override
  Widget build(BuildContext context) {
    loggingPageNotifier = Provider.of<LoggingPageNotifier>(context);
    return loggingPageNotifier.currentPage == LoggingPageType.SIGNUP
          ? SignupScreen()
          : LoginScreen();
  }
}
