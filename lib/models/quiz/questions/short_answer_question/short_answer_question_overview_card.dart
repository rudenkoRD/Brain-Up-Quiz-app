import 'package:flutter/material.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/short_answer_question/short_answer_question.dart';

class ShortAnswerQuestionOptionsOverview extends StatelessWidget {
  final ShortAnswerQuestion question;
  final bool isEditable;

  const ShortAnswerQuestionOptionsOverview(
      {Key key,@required this.question, @required this.isEditable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEditable
        ? Text(
            '${S.of(context).correct_option_label}: ${question.correctAnswer}')
        : Text(S.of(context).user_answer);
  }
}
