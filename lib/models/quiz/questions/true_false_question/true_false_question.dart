import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:flutter/material.dart';
import 'package:schoollearning/models/quiz/questions/true_false_question/true_false_question_overview_card.dart';

import '../question_type.dart';

class TrueFalseQuestion extends Question {
  bool _answer;
  bool _selectedAnswer;

  TrueFalseQuestion(String question, bool answer)
      : super(question, QuestionType.TRUE_FALSE, ["yes_label", "no_label"]) {
    this._answer = answer;
  }

  TrueFalseQuestion.blank()
      : super('', QuestionType.TRUE_FALSE, ["yes_label", "no_label"]) {
    this._answer = true;
  }

  bool get answer => _answer;

  set answer(newAnswer) => _answer = newAnswer;

  TrueFalseQuestion.fromJson(String question, Map data)
      : super(question, QuestionType.TRUE_FALSE, ["yes_label", "no_label"]) {
    _answer = data['correct_answer'];
  }

  Map<String, dynamic> toMap() {
    return {'correct_answer': _answer};
  }

  // Widget trueFalseQuestionContent(TrueFalseQuestion question, int index) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Text(
  //             '№${index + 1}:  ${AppLocalizations.of(context).translate('yes_no_question_label')}',
  //           ),
  //           Icon(
  //             Icons.edit,
  //             color: Colors.blueGrey[700],
  //           )
  //         ],
  //       ),
  //       Divider(),
  //       Text(
  //         question.question,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       Divider(),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[Text('да'), Text('нет')],
  //       ),
  //     ],
  //   );
  // }

  @override
  testingWidget(updateState, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  question,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Text(S.of(context).select_correct_answer_label),
        Divider(
          thickness: 2,
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey[400],
                      margin: EdgeInsets.only(right: 3.0, left: 6.0),
                      child: RadioListTile(
                        value: true,
                        onChanged: (newValue) {
                          _selectedAnswer = newValue;
                          updateState();
                        },
                        groupValue: _selectedAnswer,
                        title: Text(S.of(context).yes_label),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey[400],
                      margin: EdgeInsets.only(right: 6.0, left: 3.0),
                      child: RadioListTile(
                        value: false,
                        onChanged: (newValue) {
                          _selectedAnswer = newValue;
                          updateState();
                        },
                        groupValue: _selectedAnswer,
                        title: Text(S.of(context).no_label),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  updateCurrentTestingOptions() {}

  @override
  get scoreAvailable => 1;

  @override
  int checkAnswer() {
    if (_selectedAnswer == null) return -1;

    if (_selectedAnswer == answer)
      return 1;
    else
      return 0;
  }

  @override
  Widget questionOptionsOverview(bool isEditable) {
    return TrueFalseQuestionOptionsOverview(
      question: this,
      isEditable: isEditable,
    );
  }
}
