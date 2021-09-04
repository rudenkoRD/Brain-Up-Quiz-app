import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 100.0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'BrainUp:',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 60,
                fontWeight: FontWeight.bold,
                height: 1),
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
                text: 'Quiz',
                style: TextStyle(
                    fontSize: 70,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    height: 0.9),
                children: [
                  TextSpan(
                      text: '.',
                      style: TextStyle(color: Colors.orange)),
                ]),
          ),
        ],
      ),
    );
  }
}

