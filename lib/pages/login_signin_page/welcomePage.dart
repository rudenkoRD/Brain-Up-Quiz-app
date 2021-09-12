import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/notifiers/logging_page_notifier.dart';
import 'package:schoollearning/pages/login_signin_page/sign_up_page/sign_up_page.dart';

import 'login_page/login_page.dart';


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
