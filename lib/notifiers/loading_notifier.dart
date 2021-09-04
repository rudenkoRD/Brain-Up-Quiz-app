import 'package:flutter/widgets.dart';

class LoadingNotifier with ChangeNotifier {
  bool _isLoading = false;

  get isLoading => _isLoading;

  set isLoading(newValue) {
    _isLoading = newValue;
    notifyListeners();
  }
}