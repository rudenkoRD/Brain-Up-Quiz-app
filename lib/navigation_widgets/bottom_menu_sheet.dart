import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/page.dart';
import 'package:schoollearning/notifiers/page_notifier.dart';

class BottomMenuSheet extends StatefulWidget {
  @override
  _BottomMenuSheetState createState() => _BottomMenuSheetState();
}

class _BottomMenuSheetState extends State<BottomMenuSheet> {
  final textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    PageNotifier pageNotifier = Provider.of<PageNotifier>(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).main_screen_title,
                style: textStyle,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              pageNotifier.setPage(AppPage.HOME);
            },
          ),
          FlatButton(
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).favourite_screen_title,
                style: textStyle,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              pageNotifier.setPage(AppPage.FEATURED);
            },
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          FlatButton(
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).settings_screen_title,
                style: textStyle,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              pageNotifier.setPage(AppPage.SETTINGS);
            },
          ),
        ],
      ),
      height: 250.0,
    );
  }
}