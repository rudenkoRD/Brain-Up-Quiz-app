import 'dart:math';

import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/multiple_choice_question/multiple_choice_question_overview_card.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:flutter/material.dart';

import '../question_type.dart';

class MultipleChoiceQuestion extends Question {
  List<String> _correctOptions;
  List<bool> _userAnswer = List();
  List<String> _optionsList = List();

  MultipleChoiceQuestion(String question, List<String> answerOptions,
      List<String> correctOptions)
      : super(question, QuestionType.MULTIPLE_CHOICE, answerOptions) {
    this._correctOptions = correctOptions;
  }

  MultipleChoiceQuestion.blank()
      : super('', QuestionType.MULTIPLE_CHOICE, List<String>()) {
    this._correctOptions = [''];
  }

  MultipleChoiceQuestion.fromJson(String question, Map data) : super(question, QuestionType.MULTIPLE_CHOICE, data['options'].cast<String>()){
    _correctOptions = data['correct_options'].cast<String>();
  }

  List<String> get correctOptions => _correctOptions;

  Map<String, dynamic> toMap() {
    return {'correct_options': _correctOptions, 'options': options};
  }

  int getNumberOfCorrectAnswers(List<String> answers) {
    int result = 0;
    for (String option in answers)
      if (_correctOptions.contains(option)) result++;

    return result;
  }

  // Widget multipleChoiceQuestionContent(
  //     MultipleChoiceQuestion question, int index) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Text(
  //             '№${index + 1}:  несколько правильных ответов',
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
  //       QuestionUi.showAnswerOptions(question),
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
        Text(S.of(context).select_all_correct_answers_label),
        Divider(thickness: 2,),
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              color: Colors.blueGrey[400],
              child: CheckboxListTile(
                value: _userAnswer[index],

                onChanged: (newValue){
                  _userAnswer[index] = newValue;
                  updateState();
                },

                title: Text(
                  _optionsList[index],
                  style: TextStyle(color: Colors.white),
                  maxLines: 10,
                ),
              ),
            ),
            itemCount: _optionsList.length,
          ),
        )
      ],
    );
  }

  @override
  updateCurrentTestingOptions() {
    _optionsList.clear();
    _optionsList.addAll(options);
    _optionsList.addAll(_correctOptions);
    _optionsList.shuffle();

    _userAnswer = List.filled(_optionsList.length, false);
  }

  @override
  get scoreAvailable => correctOptions.length;

  @override
  int checkAnswer() {
    List<String> userAnswerStrings = List();
    for(int i = 0; i < _optionsList.length; i++){
      if(_userAnswer[i]) userAnswerStrings.add(_optionsList[i]);
    }

    int userScore = 0;

    for(int i = 0; i < userAnswerStrings.length; i++){
      if(_correctOptions.contains(userAnswerStrings[i])) userScore++;
      if(!_correctOptions.contains(userAnswerStrings[i])) userScore--;
    }

    return max(userScore, 0);
  }

  @override
  Widget questionOptionsOverview(bool isEditable) {
    return MultipleChoiceQuestionOptionsOverview(question: this, isEditable: isEditable,);
  }
}
