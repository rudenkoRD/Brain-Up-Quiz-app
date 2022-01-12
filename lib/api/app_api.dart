import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoollearning/models/user.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/notifiers/loading_notifier.dart';
import 'package:schoollearning/generated/l10n.dart';


login(AppUser user, AuthNotifier authNotifier, LoadingNotifier loadingNotifier, BuildContext context) async {
  loadingNotifier.isLoading = true;

  UserCredential authResult =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email, password: user.password).catchError((error) {
    loadingNotifier.isLoading = false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          S.of(context).login_fail_label,
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
        S.of(context).signup_fail_label,
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
