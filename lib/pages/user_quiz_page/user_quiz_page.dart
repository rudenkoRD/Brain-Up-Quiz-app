import 'package:flutter/material.dart';
import 'package:schoollearning/models/quiz/quiz_list.dart';

class UserQuizPage extends StatefulWidget {

  @override
  _UserQuizPageState createState() => _UserQuizPageState();
}

class _UserQuizPageState extends State<UserQuizPage> {
  @override
  Widget build(BuildContext context) {
    return QuizList(true);
  }
}
