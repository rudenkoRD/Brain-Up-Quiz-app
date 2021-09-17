import 'package:flutter/material.dart';
import 'package:schoollearning/pages/featured_page/featured_page.dart';
import 'package:schoollearning/pages/home_page/home_page.dart';
import 'package:schoollearning/pages/settings_page/settings_page.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/pages/user_quiz_page/user_quiz_page.dart';


enum AppPage {
  HOME,
  FEATURED,
  SETTINGS,
  USER_QUIZ,
}

extension PageExtension on AppPage {
  String titleName(context) {
    switch(this) {
      case AppPage.HOME : return S.of(context).main_screen_title;
      case AppPage.FEATURED : return  S.of(context).favourite_screen_title;
      case AppPage.SETTINGS : return  S.of(context).settings_screen_title;
      case AppPage.USER_QUIZ : return S.of(context).my_tests_bar_title;
      default : throw('no such app page');
    }
  }

  Widget get pageWidget{
    switch(this) {
      case AppPage.HOME : return HomePage();
      case AppPage.FEATURED : return  FeaturedPage();
      case AppPage.SETTINGS : return  SettingsPage();
      case AppPage.USER_QUIZ : return UserQuizPage();
      default : throw('no such app page');
    }
  }
}