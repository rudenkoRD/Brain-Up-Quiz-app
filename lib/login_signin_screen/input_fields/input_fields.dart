import 'package:flutter/material.dart';
import 'package:schoollearning/model/user.dart';
import '../text_validator.dart';
import 'dataField.dart';

Widget emailField(AppUser user) {
  return DataField(
    icon: Icon(Icons.email),
    labelText: 'EMAIL',
    isPassword: false,
    onSaved: (email) {
      user.email = email;
    },
    validation: (data) {
      return TextValidator().validateEmail(data);
    },
  );
}

Widget usernameField(AppUser user) {
  return DataField(
    icon: Icon(Icons.person),
    labelText: 'USERNAME',
    isPassword: false,
    onSaved: (username) {
      user.username = username;
    },
    validation: (data) {
      return TextValidator().validateUserName(data);
    },
  );
}

Widget passwordField(AppUser user) {
  return DataField(
    isPassword: true,
    labelText: 'PASSWORD',
    icon: Icon(Icons.lock),
    onSaved: (password){
      user.password = password;
    },
    validation: (data){
      return TextValidator().checkIfEmptyPassword(data);
    },
  );
}