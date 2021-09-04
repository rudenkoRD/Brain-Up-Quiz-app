import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:schoollearning/services/my_connectivity.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key key, @required this.screenContentWidget}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();

  final Widget screenContentWidget;
}

class _MyPageState extends State<MyPage> {
  Map _source = {ConnectivityResult.wifi: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  @override
  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.screenContentWidget,

        _source.keys.toList()[0] == ConnectivityResult.none ?
        Container(
          color: Colors.black26.withOpacity(0.5),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  // color: Colors.blueGrey,
                  child: Text(
                    'Waiting for internet connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.none
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                SpinKitWave(
                  size: 40,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ) : Container(),
      ],
    );
  }
}
