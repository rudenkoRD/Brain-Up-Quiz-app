import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/matching_question/matching_question_overview_card.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:flutter/material.dart';
import '../../../pair.dart';
import '../question_type.dart';

class MatchingQuestion extends Question {
  List<Pair> _answers;
  List<String> _questionOptions;
  List<String> _answerOptions;
  List<String> _userAnswer = List();
  Function() _updateState;

  MatchingQuestion(String question, List<Pair> answers)
      : super(question, QuestionType.MATCHING,
            null) {
    this._answers = answers;
  }

  MatchingQuestion.blank()
      : super('', QuestionType.MATCHING, List<String>()) {
    this._answers = [Pair('','')];
  }

  Map<String, dynamic> toMap() {
    List<String> parsedAnswers = List.generate(answers.length, (index) => '${_answers[index].first}:${_answers[index].second}');
    return {'answers': parsedAnswers};
  }

  MatchingQuestion.fromJson(String question, Map data) : super(question, QuestionType.MATCHING, null){
    List<String> parsedAnswers = data['answers'].cast<String>();
    _answers = List.generate(parsedAnswers.length, (index){
      var split = parsedAnswers[index].split(':');
      return Pair(split[0],split[1]);
    });
  }

  List<String> get questionOptions{
    List<String> res = List();
    _answers.forEach((element) {
      res.add(element.first);
    });
    return res;
  }
  List<String> get answerOptions {
    List<String> res = List();
    _answers.forEach((element) {
      res.add(element.second);
    });
    return res;
  }
  List<Pair> get answers => _answers;

  @override
  testingWidget(updateState, context) {
    this._updateState = updateState;
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
        Text(S.of(context).match_all_options_with_correct_answers_label),
        Divider(thickness: 2,),
        Expanded(
          flex: 5,
          child: Column(
            children: List.generate(_questionOptions.length, (index) => optionTile(index))
          ),
        ),
      ],
    );
  }

  Widget optionTile(index){
    return Card(
      color: Colors.blueGrey[400],
      child: Container(
        margin: EdgeInsets.all(4),
        color: Colors.blueGrey[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  _questionOptions[index],
                  maxLines: 10,
                ),
              ),
            ),
            Expanded(
              child: DropdownButton(
                isExpanded: true,
                isDense: true,
                value: _userAnswer[index],
                items: answerOptionsList(),
                onChanged: (newValue) => changeUserAnswer(newValue, index),
                dropdownColor: Colors.blueGrey[400],
              ),
            )
          ],
        ),
      ),
    );
  }

  changeUserAnswer(newValue, index){
    _userAnswer[index] = newValue;
    _updateState();
  }

  List<DropdownMenuItem<String>> answerOptionsList() {
    return List.generate(_answerOptions.length, (index) => DropdownMenuItem(
      value: _answerOptions[index],
      child: Container(
        color: Colors.blueGrey[400],
        child: Text('${_answerOptions[index]}'),
      ),
    ));
  }

  @override
  updateCurrentTestingOptions() {
    _questionOptions = questionOptions;
    for(int i = 0; i < _questionOptions.length; i++){
      if(_questionOptions[i].isEmpty) _questionOptions.removeAt(i);
    }
    _questionOptions.shuffle();
    _userAnswer = List(_questionOptions.length);

    _answerOptions = answerOptions;
    _answerOptions.shuffle();
  }

  @override
  get scoreAvailable {
    int res = 0;
    _answers.forEach((pair) { if(pair.first.isNotEmpty) res++;});
    return res;
  }

  @override
  int checkAnswer() {
    int userScore = 0;
    for(int i = 0; i < _questionOptions.length; i++){
      print('${_questionOptions[i]}');
      for(int j = 0; j < answers.length; j++){
        if(answers[j].first == _questionOptions[i]){
          print('${answers[j].first} : ${answers[j].second} :: ${_userAnswer[i]}');
          if(_userAnswer[i] == answers[j].second) userScore++;
          if(_userAnswer[i] == null) return -1;
        }
      }
    }
    return userScore;
  }

  @override
  Widget questionOptionsOverview(bool isEditable) {
    return MatchingQuestionOptionsOverview(question: this, isEditable: isEditable,);
  }

}
