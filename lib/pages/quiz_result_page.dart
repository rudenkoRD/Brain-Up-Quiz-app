import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/quiz.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/services/firestore_database.dart';

class QuizResultPage extends StatefulWidget {
  final double userScore;
  final Quiz quiz;

  QuizResultPage(this.userScore, this.quiz);

  @override
  _QuizResultPageState createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  AuthNotifier authNotifier;

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    int mark = (12.0 * widget.userScore) ~/ 100.0;

    print(authNotifier.user.userData
        .completedQuizData[widget.quiz.id]
    ['vote']);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          title: Text(
            S.of(context).result_title,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(6.0),
            color: Colors.blueGrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width / 2,
                        lineWidth: 13.0,
                        animation: true,
                        percent: widget.userScore / 100,
                        center: Text(
                          '${widget.userScore.toStringAsFixed(2)}%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.white),
                        ),
                        footer: RichText(
                          text: TextSpan(
                              text: '${S.of(context).mark_label}: ',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                              children: [
                                TextSpan(
                                  text: '$mark',
                                  style: TextStyle(
                                      color: translatePercentToColor(
                                          widget.userScore.toInt()),
                                      fontSize: 35),
                                )
                              ]),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.green.withBlue(60),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                if (authNotifier.user.userData
                                    .completedQuizData[widget.quiz.id]['vote'] ==
                                    '-1') {
                                  widget.quiz.negativeMarks--;
                                }
                                if (authNotifier.user.userData
                                    .completedQuizData[widget.quiz.id]['vote'] ==
                                    '1') {
                                  widget.quiz.positiveMarks--;
                                  authNotifier.user.userData
                                      .completedQuizData[widget.quiz.id]['vote'] = '0';
                                } else {
                                  widget.quiz.positiveMarks++;
                                  authNotifier.user.userData
                                      .completedQuizData[widget.quiz.id]['vote'] = '1';
                                }
                              });
                            },
                            color: authNotifier.user.userData
                                            .completedQuizData[widget.quiz.id]
                                        ['vote'] ==
                                    '1'
                                ? Colors.blueGrey[600]
                                : Colors.transparent,
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.green[400],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                if (authNotifier.user.userData
                                    .completedQuizData[widget.quiz.id]['vote'] ==
                                    '1') {
                                  widget.quiz.positiveMarks--;
                                }
                                if (authNotifier.user.userData
                                    .completedQuizData[widget.quiz.id]['vote'] ==
                                    '-1') {
                                  widget.quiz.negativeMarks--;
                                  authNotifier.user.userData
                                      .completedQuizData[widget.quiz.id]['vote'] = '0';
                                } else {
                                  widget.quiz.negativeMarks++;
                                  authNotifier.user.userData
                                      .completedQuizData[widget.quiz.id]['vote'] = '-1';
                                }
                              });
                            },
                            color: authNotifier.user.userData
                                            .completedQuizData[widget.quiz.id]
                                        ['vote'] ==
                                    '-1'
                                ? Colors.blueGrey[600]
                                : Colors.transparent,
                            child: Icon(
                              Icons.thumb_down,
                              color: Colors.red[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    await FirestoreService()
                        .addOrUpdateUserData(authNotifier.user);
                    await FirestoreService().addOrUpdateQuiz(widget.quiz);
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    S.of(context).continue_label,
                    style: TextStyle(fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color translatePercentToColor(int value) {
    int red = 0;
    int green = 0;
    const blue = 20;

    if (value <= 50) {
      red = 220;
      green = (255 * value) ~/ 50;
    } else {
      red = (255 * (100 - value)) ~/ 40;
      green = 220;
    }

    return Color.fromRGBO(red, green, blue, 1);
  }
}
