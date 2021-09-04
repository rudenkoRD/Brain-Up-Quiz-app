import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/model/page.dart';
import 'package:schoollearning/model/quiz/quiz.dart';
import 'package:schoollearning/navigation/route_names.dart';
import 'package:schoollearning/notifier/auth_notifier.dart';
import 'package:schoollearning/notifier/page_notifier.dart';

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

class MyFloatingActionButton extends StatefulWidget {
  @override
  _MyFloatingActionButtonState createState() =>
      _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState
    extends State<MyFloatingActionButton> {

  final GlobalKey<FormState> _createQuizDialogFormKey =
  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      elevation: 4.0,
      onPressed: () {
        _showCreatingQuizDialog(context);
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }

  _showCreatingQuizDialog(BuildContext context) {
    Quiz newQuiz = Quiz.newEmpty();

    AuthNotifier authNotifier =
    Provider.of<AuthNotifier>(context, listen: false);

    newQuiz.setAuthor(authNotifier.user.username);

    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            S.of(context).create_new_test_heading,
          ),
          backgroundColor: Colors.blueGrey[200],
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(20))),
          content: Container(
            child: Form(
              key: _createQuizDialogFormKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    validator: (String val) {
                      if (val.trim().isEmpty) {
                        return S.of(context).field_cant_be_empty_label;
                      }
                      return null;
                    },
                    onSaved: (String val) {
                      newQuiz.setTitle(val);
                    },
                    decoration: InputDecoration(
                        labelText: S.of(context).heading_label,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ),
                  TextFormField(
                    validator: (String val) {
                      if (val.trim().isEmpty) {
                        return S.of(context).field_cant_be_empty_label;
                      }
                      return null;
                    },
                    onSaved: (String val) {
                      newQuiz.setSubject(val);
                    },
                    decoration: InputDecoration(
                      labelText: S.of(context).subject_label,
                      labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel_label),
              color: Colors.redAccent,
            ),
            FlatButton(
              onPressed: () {
                if (_createQuizDialogFormKey.currentState
                    .validate()) {
                  _createQuizDialogFormKey.currentState.save();

                  Navigator.popAndPushNamed(
                      context, routeQuizOverview,
                      arguments: newQuiz);
                }
              },
              child: Text(S.of(context).create_label),
              color: Colors.green,
            )
          ],
        ));
  }
}

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