import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:flutter/material.dart';
import 'package:schoollearning/models/quiz/questions/short_answer_question/short_answer_question_overview_card.dart';

import '../question_type.dart';

class ShortAnswerQuestion extends Question {
  String _correctAnswer;
  String _userAnswer = '';
  GlobalKey<FormState> answerFormKey = GlobalKey<FormState>();

  ShortAnswerQuestion(String question, String correctAnswer)
      : super(question, QuestionType.SHORT_ANSWER, null) {
    this._correctAnswer = correctAnswer;
  }

  ShortAnswerQuestion.blank()
      : super('', QuestionType.SHORT_ANSWER, null) {
    this._correctAnswer = '';
  }

  ShortAnswerQuestion.fromJson(String question, Map data) : super(question, QuestionType.SHORT_ANSWER, null){
    _correctAnswer = data['correct_answer'];
  }

  String get correctAnswer => _correctAnswer;
  set correctAnswer(newValue) => _correctAnswer = newValue;

  Map<String, dynamic> toMap() {
    return {
      'correct_answer': _correctAnswer,
    };
  }

  // Widget shortAnswerQuestionContent(
  //     ShortAnswerQuestion question, int index) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Text(
  //             '№${index + 1}:  ${AppLocalizations.of(context).translate('short_answer_question_label')}',
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
  //       Text('пользовательский ответ'),
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
        Text(S.of(context).enter_correct_answer_label),
        Divider(thickness: 2,),
        Expanded(
          flex: 5,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(6.0),
                padding: EdgeInsets.all(6.0),
                color: Colors.blueGrey[400],
                child: Form(
                  key: answerFormKey,
                  child: TextFormField(
                    validator: (value){
                      if(value.isEmpty) return S.of(context).field_cant_be_empty_label;
                      return null;
                    },
                    onSaved: (value){
                      _userAnswer = value;
                    },
                    decoration: InputDecoration(
                      labelText: S.of(context).answer_label
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  updateCurrentTestingOptions() {
    _userAnswer = '';
  }

  @override
  get scoreAvailable => 1;

  @override
  int checkAnswer() {
    if(answerFormKey.currentState.validate()) answerFormKey.currentState.save();

    if(_userAnswer.isEmpty) return -1;

    if(_userAnswer.trim().toLowerCase() == _correctAnswer.trim().toLowerCase()) return 1;
    else return 0;
  }

  @override
  Widget questionOptionsOverview(bool isEditable) {
    return ShortAnswerQuestionOptionsOverview(question: this, isEditable: isEditable,);
  }
}
