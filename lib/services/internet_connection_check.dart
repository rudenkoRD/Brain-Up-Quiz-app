import 'dart:async';
import 'package:flutter/material.dart';
import'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:schoollearning/generated/l10n.dart';

class InternetConnection {
  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentMessage = "Unknown";
  bool isDialogShowing = false;

  void _showDialog(String title,String content ,BuildContext context) {
    isDialogShowing = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.blueGrey[900].withOpacity(0.8),
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(S.of(context).waiting_for_wifi_label),
                    SizedBox(height: 20,),
                    SpinKitWave(
                      color: Colors.orange,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                      child: new Text(S.of(context).exit_label))
                ]
            ),
          );
        }
    ).then((value) => isDialogShowing = false);
  }

  checkConnection(BuildContext context) {
    DataConnectionChecker().checkInterval = Duration(seconds: 3);
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        case DataConnectionStatus.connected:
          internetStatus = "Connected to the Internet";
          contentMessage = "Connected to the Internet";
          if(isDialogShowing) Navigator.pop(context);
          break;
        case DataConnectionStatus.disconnected:
          internetStatus = "You are disconnected to the Internet. ";
          contentMessage = "Please check your internet connection";
          _showDialog(internetStatus,contentMessage,context);
          break;
      }
    });
  }
}