import 'package:flutter/material.dart';
import 'package:schoollearning/pages/featured_page.dart';
import 'package:schoollearning/pages/home_page.dart';
import 'package:schoollearning/pages/settings_page.dart';
import 'package:schoollearning/generated/l10n.dart';


enum AppPage {
  HOME,
  FEATURED,
  SETTINGS
}

extension PageExtension on AppPage {
  String titleName(context) {
    switch(this) {
      case AppPage.HOME : return S.of(context).main_screen_title;
      case AppPage.FEATURED : return  S.of(context).favourite_screen_title;
      case AppPage.SETTINGS : return  S.of(context).settings_screen_title;
      default : return  S.of(context).main_screen_title;
    }
  }

  Widget get pageWidget{
    switch(this) {
      case AppPage.HOME : return HomePage();
      case AppPage.FEATURED : return  FeaturedPage();
      case AppPage.SETTINGS : return  SettingsPage();
      default : return HomePage();
    }
  }
}