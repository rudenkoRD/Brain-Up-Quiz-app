import 'package:flutter/material.dart';
import 'package:schoollearning/models/page.dart';

class PageNotifier with ChangeNotifier {
  AppPage _currentPage = AppPage.HOME;

  void setPage(AppPage page) {
    this._currentPage = page;
    notifyListeners();
  }
  
  get currentPage => _currentPage;

  Widget get pageWidget => _currentPage.pageWidget;
  String titleName(context) => _currentPage.titleName(context);
}
