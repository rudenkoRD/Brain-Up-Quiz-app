import 'package:flutter/material.dart';

import 'bottom_menu_sheet.dart';

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blueGrey[900],
      notchMargin: 10.0,
      child: Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.blueGrey[700],
                    elevation: 4.0,
                    builder: (context) => BottomMenuSheet());
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}