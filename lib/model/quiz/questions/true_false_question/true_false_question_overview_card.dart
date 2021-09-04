import 'package:flutter/material.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/model/quiz/questions/true_false_question/true_false_question.dart';

class TrueFalseQuestionOptionsOverview extends StatelessWidget {
  final TrueFalseQuestion question;
  final bool isEditable;

  const TrueFalseQuestionOptionsOverview(
      {Key key,@required this.question, @required this.isEditable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          S.of(context).yes_label,
          style: TextStyle(
              color: question.answer
                  ? (isEditable ? Colors.green[800] : Colors.black87)
                  : Colors.black87),
        ),
        Text(
          S.of(context).no_label,
          style: TextStyle(
              color: !question.answer
                  ? (isEditable ? Colors.green[800] : Colors.black87)
                  : Colors.black87),
        )
      ],
    );
  }
}
