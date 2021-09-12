import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/models/user.dart';
import 'package:schoollearning/pages/login_signin_page/widgets/input_fields/input_fields.dart';

class SingUpForm extends StatefulWidget {
  const SingUpForm(this._formKey);
  final GlobalKey<FormState> _formKey;

  @override
  _SingUpFormState createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppUser>(
      builder: (context, user, child) {
        return Container(
          child: Form(
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                usernameField(user),
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

