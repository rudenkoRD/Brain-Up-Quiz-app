import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoollearning/model/user.dart';
import 'package:schoollearning/notifier/auth_notifier.dart';
import 'package:schoollearning/notifier/loading_notifier.dart';

login(AppUser user, AuthNotifier authNotifier, LoadingNotifier loadingNotifier, BuildContext context) async {
  loadingNotifier.isLoading = true;

  UserCredential authResult =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email, password: user.password).catchError((error) {
    loadingNotifier.isLoading = false;
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Fail. Check your password and username',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  });

  loadingNotifier.isLoading = false;

  if (authResult != null) {
    User firebaseUser = authResult.user;

    if (user != null) {
      print("Long in: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(AppUser user, AuthNotifier authNotifier, LoadingNotifier loadingNotifier, BuildContext context) async {
  loadingNotifier.isLoading = true;

  UserCredential authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) {
    print(error);
    loadingNotifier.isLoading = false;
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'Fail. Try again later',
        style: TextStyle(color: Colors.red),
      ),
    ));
  });

  if (authResult != null) {
    User firebaseUser = authResult.user;

    if (user != null) {
      await firebaseUser.updateDisplayName(user.username);
      await firebaseUser.reload();

      print("Sigh up: $firebaseUser");
      User currentUser = FirebaseAuth.instance.currentUser;

      loadingNotifier.isLoading = false;
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  User firebaseUser = FirebaseAuth.instance.currentUser;

  authNotifier.isInitialized = true;
  if (firebaseUser != null) {
    authNotifier.setUser(firebaseUser);
  }
}
