import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/api/app_api.dart';
import 'package:schoollearning/models/user.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/notifiers/loading_notifier.dart';
import 'package:schoollearning/notifiers/logging_page_notifier.dart';
import 'package:schoollearning/services/internet_connection_check.dart';
import '../widgets/app_title.dart';
import 'login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppUser _user = AppUser();
  LoggingPageNotifier loggingPageNotifier;

  InternetConnection internetConnection = InternetConnection();

  @override
  void initState() {
    internetConnection.checkConnection(context);
    super.initState();
  }

  @override
  void dispose() {
    internetConnection.listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loggingPageNotifier = Provider.of<LoggingPageNotifier>(context);

    var height = MediaQuery.of(context).size.height - 50;
    var width = MediaQuery.of(context).size.width;



    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AppTitle(),
                  Column(
                    children: <Widget>[
                      loginForm(),
                      SizedBox(
                        height: 10,
                      ),
                      forgetPasswordButton(),
                      SizedBox(
                        height: 20,
                      ),
                      loginButton(),
                      SizedBox(
                        height: 15,
                      ),
                      // googleLoginButton(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      switchToRegisterButton(width),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Widgets

  Widget loginForm() => Container(
      padding: EdgeInsets.only(top: 35.0, left: 30.0, right: 30.0),
      child: Provider.value(
        value: _user,
        child: LoginForm(_formKey),
      ),
    );

  Widget forgetPasswordButton() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(right: 30),
        child: InkWell(
          onTap: () {
            //TODO reset password
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
                fontFamily: 'Baloo',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    ],
  );

  Widget loginButton() => Container(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Material(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.orange,
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          _validateLogInForm(context);
        },
        child: Center(
            child: Text('LOGIN',
                style: TextStyle(
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.white))),
      ),
    ),
  );

  Widget googleLoginButton() => Container(
    height: 40,
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Material(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          //TODO login with google
        },
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                      'assets/images/google_logo.png'),
                ),
                Text('LOG IN WITH GOOGLE',
                    style: TextStyle(
                        fontFamily: 'Baloo',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Colors.black87)),
              ],
            )),
      ),
    ),
  );

  Widget switchToRegisterButton(width) => Container(
    width: width,
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Don\'t have an account?'),
          InkWell(
            onTap: () {
              changePageToSignUp();
            },
            child: Text('Register',
              style: TextStyle(
                  color: Colors.orange,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),),
          ),
        ],
      ),
    ),
  );
  //Functions

  changePageToSignUp(){
    setState(() {
      loggingPageNotifier.currentPage = LoggingPageType.SIGNUP;
    });
  }

  _validateLogInForm(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    LoadingNotifier loadingNotifier = Provider.of<LoadingNotifier>(context,listen: false);

    login(_user, authNotifier, loadingNotifier,context);
  }
}
