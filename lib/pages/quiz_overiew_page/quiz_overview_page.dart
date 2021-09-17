import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/matching_question/matching_question.dart';
import 'package:schoollearning/models/quiz/questions/multiple_choice_question/multiple_choice_question.dart';
import 'package:schoollearning/models/quiz/questions/ordering_question/ordering_question.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:schoollearning/models/quiz/questions/question_type.dart';
import 'package:schoollearning/models/quiz/questions/questions_overview_list.dart';
import 'package:schoollearning/models/quiz/questions/short_answer_question/short_answer_question.dart';
import 'package:schoollearning/models/quiz/questions/single_choice_question/single_choice_question.dart';
import 'package:schoollearning/models/quiz/questions/true_false_question/true_false_question.dart';
import 'package:schoollearning/models/quiz/quiz.dart';
import 'package:schoollearning/routes/route_names.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/services/firestore_database.dart';
import 'package:schoollearning/services/internet_connection_check.dart';

class QuizOverviewPage extends StatefulWidget {
  final Quiz quiz;

  QuizOverviewPage(this.quiz);

  @override
  _QuizOverviewPageState createState() => _QuizOverviewPageState(quiz);
}

class _QuizOverviewPageState extends State<QuizOverviewPage> {
  _QuizOverviewPageState(this.quiz);

  final GlobalKey<FormState> _changingFormKey = GlobalKey<FormState>();

  InternetConnection internetConnection = InternetConnection();

  @override
  void initState() {
    internetConnection.checkConnection(context);
    super.initState();
  }

  @override
  void dispose() {
    internetConnection.listener.cancel();
    super.dispose();
  }

  Quiz quiz;
  AuthNotifier authNotifier;
  bool isUsersQuiz;

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    isUsersQuiz = authNotifier.user.username == quiz.author;
    print(isUsersQuiz);

    return WillPopScope(
      onWillPop: () async => isUsersQuiz ? false : true,
      child: Provider.value(
        value: quiz,
        child: Scaffold(
            body: Container(
              color: Colors.blueGrey,
              child: CustomScrollView(
                slivers: <Widget>[
                  QuizOverviewAppBar(
                    isUsersQuiz: isUsersQuiz,
                    authNotifier: authNotifier,
                    quiz: quiz,
                  ),
                  tasksList()
                ],
              ),
            ),
            bottomNavigationBar:
                isUsersQuiz ? quizBottomNavigationBar(context) : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: isUsersQuiz ? floatingActionButton() : null),
      ),
    );
  }

  Widget tasksList() {
    if (quiz.questions.isEmpty) {
      return SliverToBoxAdapter(
        child: Column(
          children: <Widget>[
            Text(
              S.of(context).add_question_label,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return QuestionsOverviewList();
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.orange.withOpacity(0.8),

      child: Icon(Icons.add),
      onPressed: () {
        _showSelectQuestionTypeDialog(context).then((type) {
          if (type != null) {
            Question newQuestion = SingleChoiceQuestion.blank();

            switch (type) {
              case QuestionType.SINGLE_CHOICE:
                newQuestion = SingleChoiceQuestion.blank();
                break;
              case QuestionType.MULTIPLE_CHOICE:
                newQuestion = MultipleChoiceQuestion.blank();
                break;
              case QuestionType.SHORT_ANSWER:
                newQuestion = ShortAnswerQuestion.blank();
                break;
              case QuestionType.ORDERING:
                newQuestion = OrderingQuestion.blank();
                break;
              case QuestionType.TRUE_FALSE:
                newQuestion = TrueFalseQuestion.blank();
                break;
              case QuestionType.MATCHING:
                newQuestion = MatchingQuestion.blank();
                break;
            }

            Navigator.pushNamed(context, routeEditQuizTask,
                    arguments: newQuestion)
                .then((newQuestion) {
              if (newQuestion != null && newQuestion is Question) {
                setState(() {
                  quiz.questions.add(newQuestion);
                });
              }
            });
          } else
            print('null');
        });
      },
    );
  }

  Widget bottomMenuSheet(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: ListTile(
              leading: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).heading_label,
                style: textStyle,
              ),
            ),
            onPressed: () {
              _showChangeTestPropertyDialog(
                      context,
                      S.of(context)
                          .enter_heading_label,
                      quiz.title)
                  .then((value) {
                if (value != null) {
                  setState(() {
                    quiz.setTitle(value);
                  });
                }
              });
            },
          ),
          FlatButton(
            child: ListTile(
              leading: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).subject_label,
                style: textStyle,
              ),
            ),
            onPressed: () {
              _showChangeTestPropertyDialog(
                      context,
                      S.of(context)
                          .enter_subject_label,
                      quiz.subject)
                  .then((value) {
                if (value != null)
                  setState(() {
                    quiz.setSubject(value);
                  });
              });
            },
          ),
          Divider(
            color: Colors.blueGrey,
          ),
          FlatButton(
            child: ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              title: Text(
                S.of(context).delete_label,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            onPressed: () {
              _showDeletingDialog(context);
            },
          ),
        ],
      ),
      height: 250.0,
    );
  }

  _showDeletingDialog(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.blueGrey[300],
              title: Text(
                S.of(context).delete_test_label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(S.of(context)
                  .delete_text_warning),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                      S.of(context).cancel_label),
                  color: Colors.green,
                ),
                FlatButton(
                  onPressed: () async {
                    await FirestoreService().deleteQuiz(quiz);
                    Navigator.popAndPushNamed(context, routeStart);
                  },
                  child: Text(
                      S.of(context).delete_label),
                  color: Colors.redAccent,
                ),
              ],
            ));
  }

  Future<String> _showChangeTestPropertyDialog(
      BuildContext context, String title, String prevVal) {
    String res;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
            ),
            backgroundColor: Colors.blueGrey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Container(
              child: Form(
                key: _changingFormKey,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: prevVal,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty)
                      return S.of(context)
                          .field_cant_be_empty_label;
                    return null;
                  },
                  onSaved: (String val) => res = val,
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(prevVal);
                },
                child: Text(
                  S.of(context).cancel_label,
                ),
                color: Colors.redAccent,
              ),
              FlatButton(
                onPressed: () {
                  if (_changingFormKey.currentState.validate()) {
                    _changingFormKey.currentState.save();
                    Navigator.of(context).pop(res);
                  }
                },
                child:
                    Text(S.of(context).save_label),
                color: Colors.green,
              ),
            ],
          );
        });
  }

  Future<QuestionType> _showSelectQuestionTypeDialog(
      BuildContext context) async {
    return await showDialog<QuestionType>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              backgroundColor: Colors.blueGrey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Text(S.of(context)
                  .select_question_type_label),
              children: List.generate(
                QuestionType.values.length,
                (index) => SimpleDialogOption(
                  onPressed: () =>
                      Navigator.of(context).pop(QuestionType.values[index]),
                  child: Text(QuestionType.values[index].name(context)),
                ),
              ),
            ));
  }

  Widget quizBottomNavigationBar(BuildContext context) {
    return Container(
      color: Colors.blueGrey[500],
      child: BottomAppBar(
        color: Colors.blueGrey[900],
        notchMargin: 3.0,
        shape: CircularNotchedRectangle(),
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
                      backgroundColor: Colors.blueGrey[600],
                      elevation: 4.0,
                      builder: (context) => bottomMenuSheet(context));
                },
                child: Icon(
                  Icons.build,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusCompletedCard extends StatefulWidget {
  final authNotifier;
  final Quiz quiz;

  StatusCompletedCard(this.authNotifier, this.quiz);

  @override
  _StatusCompletedCardState createState() => _StatusCompletedCardState();
}

class _StatusCompletedCardState extends State<StatusCompletedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Card(
        color: Colors.blueGrey[400],
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: Column(
            children: <Widget>[
              Text(
                '${S.of(context).mark_label}: ${widget.authNotifier.user.userData.completedQuizData[widget.quiz.id]['mark']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      setState(() {
                        if (widget.authNotifier.user.userData
                                .completedQuizData[widget.quiz.id]['vote'] ==
                            '-1') {
                          widget.quiz.negativeMarks--;
                        }
                        if (widget.authNotifier.user.userData
                                .completedQuizData[widget.quiz.id]['vote'] ==
                            '1') {
                          widget.quiz.positiveMarks--;
                          widget.authNotifier.user.userData
                              .completedQuizData[widget.quiz.id]['vote'] = '0';
                        } else {
                          widget.quiz.positiveMarks++;
                          widget.authNotifier.user.userData
                              .completedQuizData[widget.quiz.id]['vote'] = '1';
                        }
                      });
                      await FirestoreService()
                          .addOrUpdateUserData(widget.authNotifier.user);
                      await FirestoreService().addOrUpdateQuiz(widget.quiz);
                    },
                    color: widget.authNotifier.user.userData
                                .completedQuizData[widget.quiz.id]['vote'] ==
                            '1'
                        ? Colors.blueGrey
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
                    onPressed: () async {
                      setState(() {
                        if (widget.authNotifier.user.userData
                                .completedQuizData[widget.quiz.id]['vote'] ==
                            '1') {
                          widget.quiz.positiveMarks--;
                        }
                        if (widget.authNotifier.user.userData
                                .completedQuizData[widget.quiz.id]['vote'] ==
                            '-1') {
                          widget.quiz.negativeMarks--;
                          widget.authNotifier.user.userData
                              .completedQuizData[widget.quiz.id]['vote'] = '0';
                        } else {
                          widget.quiz.negativeMarks++;
                          widget.authNotifier.user.userData
                              .completedQuizData[widget.quiz.id]['vote'] = '-1';
                        }
                      });
                      await FirestoreService()
                          .addOrUpdateUserData(widget.authNotifier.user);
                      await FirestoreService().addOrUpdateQuiz(widget.quiz);
                    },
                    color: widget.authNotifier.user.userData
                                .completedQuizData[widget.quiz.id]['vote'] ==
                            '-1'
                        ? Colors.blueGrey
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
      ),
    );
  }
}

class QuizOverviewAppBar extends StatefulWidget {
  final isUsersQuiz;
  final Quiz quiz;
  final authNotifier;

  const QuizOverviewAppBar(
      {Key key, this.isUsersQuiz, this.quiz, this.authNotifier})
      : super(key: key);

  @override
  _QuizOverviewAppBarState createState() => _QuizOverviewAppBarState();
}

class _QuizOverviewAppBarState extends State<QuizOverviewAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: widget.isUsersQuiz ? false : true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          widget.isUsersQuiz
              ? RaisedButton(
                  color: Colors.green,
                  onPressed: () async {
                    await FirestoreService().addOrUpdateQuiz(widget.quiz);
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.blueGrey[900],
                  ),
                )
              : Container(),
          RaisedButton(
            color: Colors.orange[300],
            onPressed: () {
              if (widget.quiz.questions.isNotEmpty)
                Navigator.pushNamed(context, routeTesting,
                    arguments: widget.quiz);
              else
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context)
                      .quiz_should_have_questions_warning_label),
                ));
            },
            child: Row(
              children: <Widget>[
                Text(S.of(context).take_test_label),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ],
      ),
      brightness: Brightness.dark,
      elevation: 4.0,
      backgroundColor: Colors.blueGrey[900],
      expandedHeight: 310,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          color: Colors.blueGrey,
          padding: EdgeInsets.fromLTRB(
            6.0,
            MediaQuery.of(context).padding.top + AppBar().preferredSize.height,
            6.0,
            0.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.quiz.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent),
              ),
              Divider(
                thickness: 1.0,
                color: Colors.blueGrey[600],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '${S.of(context).author_label}: ${widget.quiz.author}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${S.of(context).created_at_label}: ${widget.quiz.createdAtDate}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${S.of(context).subject_label}: ${widget.quiz.subject}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${S.of(context).difficulty_label}: ${widget.quiz.difficultyTitle(context)}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${S.of(context).rating_label}: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.thumb_up,
                        color: Colors.green[400],
                      ),
                      Text(
                        widget.quiz.positiveMarks.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.thumb_down,
                        color: Colors.red[600],
                      ),
                      Text(
                        widget.quiz.negativeMarks.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  widget.isUsersQuiz ? Container() : quizStatusCard(),
                ],
              ),
              Divider(
                thickness: 1.0,
                color: Colors.blueGrey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }

  quizStatusCard() {
    if (widget.authNotifier.user.userData.completedQuizData.keys
        .contains(widget.quiz.id))
      return StatusCompletedCard(widget.authNotifier, widget.quiz);

    return StatusUncompletedCard();
  }
}

class StatusUncompletedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Card(
        color: Colors.blueGrey[400],
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: Column(
            children: <Widget>[
              Text(
                S.of(context)
                    .test_not_completed_label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                S.of(context)
                    .test_not_completed_attention,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
