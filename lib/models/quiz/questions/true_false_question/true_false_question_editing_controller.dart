import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/true_false_question/true_false_question.dart';

import '../question.dart';

class TrueFalseQuestionEditingList extends StatefulWidget {
  @override
  _TrueFalseQuestionEditingListState createState() =>
      _TrueFalseQuestionEditingListState();
}

class _TrueFalseQuestionEditingListState
    extends State<TrueFalseQuestionEditingList> {
  TrueFalseQuestion question;
  bool selectedAnswer;

  @override
  Widget build(BuildContext context) {
    question = Provider.of<Question>(context) as TrueFalseQuestion;
    selectedAnswer = question.answer;

    return Column(
      children: <Widget>[
        Card(
          color: Colors.blueGrey[300],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      value: true,
                      groupValue: selectedAnswer,
                      onChanged: (newValue) {
                        setState(() {
                          question.answer = newValue;
                        });
                      },
                    ),
                    Text(S.of(context).yes_label,),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Radio(
                      value: false,
                      groupValue: selectedAnswer,
                      onChanged: (newValue) {
                        setState(() {
                          question.answer = newValue;
                        });
                      },
                    ),
                    Text(S.of(context).no_label,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
