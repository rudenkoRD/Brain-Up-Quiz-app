import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/login_signin_screen/input_fields/input_fields.dart';
import 'package:schoollearning/model/user.dart';

class LoginForm extends StatefulWidget {
  const LoginForm(this._formKey);
  final GlobalKey<FormState> _formKey;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUser>(
      builder: (context, user, child) {
        return Container(
          child: Form(
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                emailField(user),
                passwordField(user),
              ],
            ),
          ),
        );
      },
    );
  }
}

