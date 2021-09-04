import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/quiz.dart';
import 'package:schoollearning/routes/route_names.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';

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