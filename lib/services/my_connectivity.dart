import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();
  StreamController controller = StreamController.broadcast();
  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((event) {
      _checkStatus(event);
    });
  }

  void _checkStatus(ConnectivityResult result) async{
    bool isOnline = false;

    try {
      final res = await InternetAddress.lookup('example.com');
      if(res.isNotEmpty && res[0].rawAddress.isNotEmpty){
        isOnline = true;
      }else isOnline = false;
    } on SocketException catch (e) {
      isOnline = false;
    }

    if(!controller.isClosed) controller.sink.add({result : isOnline});

  }

  void disposeStream() => controller.close();

}