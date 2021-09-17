import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:schoollearning/api/app_api.dart';
import 'package:schoollearning/models/page.dart';
import 'package:schoollearning/models/user.dart';
import 'package:schoollearning/models/user_data.dart';
import 'package:schoollearning/services/firestore_database.dart';

class AuthNotifier with ChangeNotifier {
  User _firebaseUser;
  AppUser _user;
  FirestoreService db = FirestoreService();

  AppUser get user => _user;
  bool _isInitialized = false;
  get isInitialized => _isInitialized;

  set isInitialized(newValue) {
    _isInitialized = newValue;
    notifyListeners();
  }

  void setUser(User user) {
    _firebaseUser = user;
    if(user == null) {
      _user = null;
      notifyListeners();
      return;
    }
    _user = AppUser();
    _user.email = _firebaseUser.email;
    _user.username = _firebaseUser.displayName;
    _user.uid = _firebaseUser.uid;

    db.getUsersData(_user.uid).listen((UserData data) {
      _user.userData = data;
      notifyListeners();
    });

    notifyListeners();
  }

  exitAccount(pageNotifier) {
    signout(this);
    pageNotifier.setPage(AppPage.HOME);
  }
}
