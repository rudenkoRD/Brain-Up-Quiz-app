import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schoollearning/model/quiz/questions/matching_question/matching_question.dart';

class MatchingQuestionOptionsOverview extends StatelessWidget {
  final MatchingQuestion question;
  final bool isEditable;

  const MatchingQuestionOptionsOverview(
      {Key key,@required this.question,@required this.isEditable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> options = List.generate(
        question.answers.length, (index) => question.answers[index].first);
    List<String> answers = List.generate(
        question.answers.length, (index) => question.answers[index].second);

    if (!isEditable) {
      Random rnd = Random(1234);
      options.shuffle(rnd);
      answers.shuffle(rnd);
    }

    return Column(
      children: List.generate(
          question.answers.length,
          (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                      '${index + 1}) ${options[index].isEmpty ? '-' : options[index]}'),
                  Text('${String.fromCharCode(index + 97)}) ${answers[index]}')
                ],
              )),
    );
  }
}
