import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/api/app_api.dart';
import 'package:schoollearning/login_signin_screen/widgets/app_title.dart';
import 'package:schoollearning/login_signin_screen/sign_up_screen/signup_form.dart';
import 'package:schoollearning/models/user.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/notifiers/loading_notifier.dart';
import 'package:schoollearning/notifiers/logging_page_notifier.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoggingPageNotifier loggingPageNotifier;
  AppUser _user = AppUser();

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
                      signUpForm(),
                      SizedBox(
                        height: 10,
                      ),
                      signUpButton(),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      switchToLogin(width),
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

  Widget signUpForm() => Container(
      padding: EdgeInsets.only(top: 35.0, left: 30.0, right: 30.0),
      child: Provider.value(
        value: _user,
        child: SingUpForm(_formKey),
      ),
  );

  Widget signUpButton() => Container(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 30),
    child: Material(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.orange,
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          _sighUpForm(context);
        },
        child: Center(
            child: Text('SIGN UP',
                style: TextStyle(
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.white))),
      ),
    ),
  );

  Widget switchToLogin(width) => Container(
    width: width,
    child: Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Already have an account?'),
          InkWell(
            onTap: (){
              changePageToLogIn();
            },
            child: Text('Login',
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

  changePageToLogIn(){
    setState(() {
      loggingPageNotifier.currentPage = LoggingPageType.LOGIN;
    });
  }

  _sighUpForm(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    LoadingNotifier loadingNotifier = Provider.of<LoadingNotifier>(context,listen: false);

    signup(_user, authNotifier, loadingNotifier, context);
  }

}
