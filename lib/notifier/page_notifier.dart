import 'package:flutter/material.dart';
import 'package:schoollearning/model/page.dart';

class PageNotifier with ChangeNotifier {
  AppPage _currentPage = AppPage.HOME;

  void setPage(AppPage page) {
    this._currentPage = page;
    notifyListeners();
  }

  Widget get page => _currentPage.pageWidget;
  String titleName(context) => _currentPage.titleName(context);
}
