import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:schoollearning/models/quiz/quiz.dart';
import 'package:schoollearning/routes/route_names.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/services/firestore_database.dart';
import 'package:schoollearning/services/internet_connection_check.dart';

class TestingPage extends StatefulWidget {
  final Quiz quiz;

  TestingPage(this.quiz);

  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  int currentQuestion;
  int totalQuestionsCount;
  int totalScoreAvailable;
  int userScore;
  bool _isDispose = false;
  List<Question> questions;
  AuthNotifier authNotifier;

  InternetConnection internetConnection = InternetConnection();

  @override
  void initState() {
    internetConnection.checkConnection(context);
    currentQuestion = 0;
    userScore = 0;
    totalQuestionsCount = widget.quiz.questions.length;
    questions = widget.quiz.questions;
    totalScoreAvailable = 0;
    questions.forEach((question) {
      totalScoreAvailable += question.scoreAvailable;
    });
    questions[currentQuestion].updateCurrentTestingOptions();
    super.initState();
  }

  @override
  void dispose() {
    internetConnection.listener.cancel();
    _isDispose = true;
    super.dispose();
  }

  updateState() {
    if (_isDispose == false) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.blueGrey[900],
          automaticallyImplyLeading: false,
          title: Builder(
            builder: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${currentQuestion + 1}/$totalQuestionsCount',
                  style: TextStyle(color: Colors.white),
                ),
                RaisedButton(
                  onPressed: () {
                    checkAnswer(context);
                  },
                  color: Colors.green,
                  child: currentQuestion + 1 == totalQuestionsCount
                      ? Text(S.of(context)
                          .finish_test_label)
                      : Text(
                          S.of(context).next_label),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: questions[currentQuestion].testingWidget(updateState, context),
        ),
      ),
    );
  }

  checkAnswer(context) {
    int res = questions[currentQuestion].checkAnswer();
    if (res == -1) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text(S.of(context).answer_error_label),
      ));
    } else {
      userScore += res;
      if (currentQuestion + 1 < questions.length)
        setState(() {
          currentQuestion++;
          questions[currentQuestion].updateCurrentTestingOptions();
          print('$userScore/$totalScoreAvailable');
        });
      else
        finishTest(context);
    }
  }

  void finishTest(context) async {
    double userResult =
        (userScore.toDouble() * 100.0 / totalScoreAvailable.toDouble());
    if (authNotifier.user.username != widget.quiz.author &&
        !authNotifier.user.userData.completedQuizData.keys
            .contains(widget.quiz.id)) {
      authNotifier.user.userData.completedQuizData.putIfAbsent(
          widget.quiz.id, () => {'mark': userScore.toString(), 'vote': "0"});
      widget.quiz.difficulty =
          ((widget.quiz.difficulty * widget.quiz.completedTimes) + userResult) /
              (widget.quiz.completedTimes + 1);
      widget.quiz.completedTimes++;
      await FirestoreService().addOrUpdateQuiz(widget.quiz);
      await FirestoreService().addOrUpdateUserData(authNotifier.user);

      Navigator.popAndPushNamed(context, routeQuizResult,
          arguments: [userResult, widget.quiz]);
    } else if (authNotifier.user.username != widget.quiz.author) {
      Navigator.popAndPushNamed(context, routeQuizResult,
          arguments: [userResult, widget.quiz]);
      print('ok');
    } else Navigator.pop(context);
  }
}
