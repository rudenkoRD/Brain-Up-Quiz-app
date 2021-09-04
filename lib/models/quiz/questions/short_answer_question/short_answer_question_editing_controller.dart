import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/short_answer_question/short_answer_question.dart';

import '../question.dart';

class ShortAnswerQuestionEditingList extends StatefulWidget {
  @override
  _ShortAnswerQuestionEditingListState createState() =>
      _ShortAnswerQuestionEditingListState();
}

class _ShortAnswerQuestionEditingListState
    extends State<ShortAnswerQuestionEditingList> {
  ShortAnswerQuestion question;

  @override
  Widget build(BuildContext context) {
    question = Provider.of<Question>(context) as ShortAnswerQuestion;
    return Column(
      children: <Widget>[
        Card(
          color: Colors.blueGrey[300],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              maxLength: 100,
              decoration: InputDecoration(
                labelText: S.of(context).correct_option_label,
              ),
              initialValue: question.correctAnswer,
              validator: (String value) {
                if (value.trim().isEmpty)
                  return S.of(context).field_cant_be_empty_label;
                return null;
              },
              onSaved: (String newValue) {
                question.correctAnswer = newValue;
              },
            ),
          ),
        ),
      ],
    );
  }
}
