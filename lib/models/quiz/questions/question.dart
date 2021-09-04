import 'package:flutter/material.dart';
import 'package:schoollearning/models/quiz/questions/matching_question/matching_question.dart';
import 'package:schoollearning/models/quiz/questions/multiple_choice_question/multiple_choice_question.dart';
import 'package:schoollearning/models/quiz/questions/ordering_question/ordering_question.dart';
import 'package:schoollearning/models/quiz/questions/question_type.dart';
import 'package:schoollearning/models/quiz/questions/short_answer_question/short_answer_question.dart';
import 'package:schoollearning/models/quiz/questions/single_choice_question/single_choice_question.dart';
import 'package:schoollearning/models/quiz/questions/true_false_question/true_false_question.dart';

abstract class Question {
  String _question;
  QuestionType _type;
  List<String> _answerOptions;

  int get numberOfOptions => _answerOptions.length;
  String get question => _question;
  QuestionType get type => _type;
  List<String> get options => _answerOptions;
  String questionTitle(context) => type.name(context);
  setQuestion(String newQuestion) => _question = newQuestion;
  setType(QuestionType newType) => _type = newType;

  Question(this._question, this._type, this._answerOptions);
  Question.blank();
  Question.fromJson(String question, Map data);

  updateCurrentTestingOptions();
  
  get scoreAvailable;
  
  int checkAnswer();
  
  testingWidget(Function() callBack, context);

  Map<String, dynamic> toMap();

  Widget questionOptionsOverview(bool isEditable);
}

List<String> getQuestionTypes(context) {
  List<String> res = List();
  for (var type in QuestionType.values)
    res.add(type.name(context));
  return res;
}

Map<String, dynamic> mapQuestion(Question question) {
  return {
    'question': question.question,
    'type': question.type.typeId,
    'content': question.toMap(),
  };
}

Question fromJsonQuestion(Map<String, dynamic> questionData){
  String question = questionData['question'];
  QuestionType type = QuestionType.values[int.parse(questionData['type'].toString())];
  switch (type) {
    case QuestionType.SINGLE_CHOICE:
      return SingleChoiceQuestion.fromJson(question, questionData['content']);
    case QuestionType.MULTIPLE_CHOICE:
      return MultipleChoiceQuestion.fromJson(question, questionData['content']);
    case QuestionType.TRUE_FALSE:
      return TrueFalseQuestion.fromJson(question, questionData['content']);
    case QuestionType.ORDERING:
      return OrderingQuestion.fromJson(question, questionData['content']);
    case QuestionType.SHORT_ANSWER:
      return ShortAnswerQuestion.fromJson(question, questionData['content']);
    case QuestionType.MATCHING:
      return MatchingQuestion.fromJson(question, questionData['content']);
  }
  return null;
}