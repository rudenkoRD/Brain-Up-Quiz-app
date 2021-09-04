import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/model/pair.dart';
import 'package:schoollearning/model/quiz/questions/matching_question/matching_question.dart';
import 'package:schoollearning/model/quiz/questions/matching_question/matching_question_editing_controller.dart';
import 'package:schoollearning/model/quiz/questions/multiple_choice_question/multiple_choice_question.dart';
import 'package:schoollearning/model/quiz/questions/multiple_choice_question/multiple_choice_question_editing_controller.dart';
import 'package:schoollearning/model/quiz/questions/ordering_question/ordering_question.dart';
import 'package:schoollearning/model/quiz/questions/ordering_question/ordering_question_editing_controller.dart';
import 'package:schoollearning/model/quiz/questions/question.dart';
import 'package:schoollearning/model/quiz/questions/question_type.dart';
import 'package:schoollearning/model/quiz/questions/short_answer_question/short_answer_question.dart';
import 'package:schoollearning/model/quiz/questions/short_answer_question/short_answer_question_editing_controller.dart';
import 'package:schoollearning/model/quiz/questions/single_choice_question/single_choice_question.dart';
import 'package:schoollearning/model/quiz/questions/single_choice_question/single_choice_question_editing_controller.dart';
import 'package:schoollearning/model/quiz/questions/true_false_question/true_false_question.dart';
import 'package:schoollearning/model/quiz/questions/true_false_question/true_false_question_editing_controller.dart';

class TaskEditingPage extends StatefulWidget {
  final Question question;

  TaskEditingPage(this.question);

  @override
  _TaskEditingPageState createState() => _TaskEditingPageState(question);
}

class _TaskEditingPageState extends State<TaskEditingPage> {
  _TaskEditingPageState(this.question);

  GlobalKey<FormState> _questionDataFormKey = GlobalKey<FormState>();

  Question question;
  TextStyle textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: question,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          leading: FlatButton(
            child: Icon(
              Icons.save,
              color: Colors.green,
            ),
            onPressed: () {
              if (_questionDataFormKey.currentState.validate()) {
                _questionDataFormKey.currentState.save();

                if (question is MatchingQuestion) {
                  print((question as MatchingQuestion).answers.toString());
                }

                Navigator.of(context).pop(question);
              }
            },
          ),
          title: Text(
            S.of(context).question_editing_label,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Container(
          padding: EdgeInsets.all(4.0),
          color: Colors.blueGrey,
          child: Form(
            key: _questionDataFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  editTaskQuestion(),
                  SizedBox(
                    height: 10,
                  ),
                  editTaskType(),
                  SizedBox(
                    height: 20.0,
                  ),
                  optionsListView(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _addNewOption(context);
          },
        ),
      ),
    );
  }

  Widget editTaskQuestion() {
    return TextFormField(
      maxLength: 100,
      decoration: InputDecoration(
        labelText: S.of(context).question_label,
      ),
      initialValue: question.question,
      validator: (String value) {
        if (value.trim().isEmpty)
          return S.of(context)
              .field_cant_be_empty_label;
        return null;
      },
      onSaved: (String newValue) {
        question.setQuestion(newValue);
      },
    );
  }

  void changeQuestionType(String newType) {
    setState(() {
      switch (QuestionType.values[getQuestionTypes(context).indexOf(newType)]) {
        case QuestionType.SINGLE_CHOICE:
          question = SingleChoiceQuestion.blank();
          break;
        case QuestionType.MULTIPLE_CHOICE:
          question = MultipleChoiceQuestion.blank();
          break;
        case QuestionType.SHORT_ANSWER:
          question = ShortAnswerQuestion.blank();
          break;
        case QuestionType.ORDERING:
          question = OrderingQuestion.blank();
          break;
        case QuestionType.TRUE_FALSE:
          question = TrueFalseQuestion.blank();
          break;
        case QuestionType.MATCHING:
          question = MatchingQuestion.blank();
      }
    });
  }

  List<DropdownMenuItem<String>> getQuestionTypeItems() {
    List<DropdownMenuItem<String>> items = List();
    for (String s in getQuestionTypes(context)) {
      items.add(DropdownMenuItem(
        value: s,
        child: Container(
          color: Colors.blueGrey,
          child: Text(s),
        ),
      ));
    }
    return items;
  }

  Widget optionsListView() {
    switch (question.type) {
      case QuestionType.SINGLE_CHOICE:
        return SingleChoiceQuestionEditingList();
      case QuestionType.MULTIPLE_CHOICE:
        return MultipleChoiceQuestionEditingList();
      case QuestionType.SHORT_ANSWER:
        return ShortAnswerQuestionEditingList();
      case QuestionType.ORDERING:
        return OrderingQuestionEditingList();
      case QuestionType.TRUE_FALSE:
        return TrueFalseQuestionEditingList();
      case QuestionType.MATCHING:
        return MatchingQuestionEditingList();
      default:
        return null;
    }
  }

  Widget editTaskType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          S.of(context).question_type_label,
          style: textStyle,
        ),
        DropdownButton(
          value: question.type.name(context),
          isDense: true,
          items: getQuestionTypeItems(),
          onChanged: changeQuestionType,
        ),
      ],
    );
  }

  void _addNewOption(context) async {
    if (question.type == QuestionType.MULTIPLE_CHOICE) {
      _showQuestionOptionSelectDialog(context).then((value) {
        setState(() {
          if (value == QuestionOption.CORRECT)
            (question as MultipleChoiceQuestion).correctOptions.add('');
          else
            question.options.add('');
        });
      });
    } else if (question.type == QuestionType.MATCHING) {
      setState(() {
        (question as MatchingQuestion).answers.add(
            Pair('', ''));
      });
    } else if (question.type != QuestionType.SHORT_ANSWER)
      setState(() {
        question.options.add('');
      });
  }

  Future<QuestionOption> _showQuestionOptionSelectDialog(context) async {
    return showDialog<QuestionOption>(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.blueGrey[200],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Text(S.of(context).option_type_label),
        children: <Widget>[
          SimpleDialogOption(
            child: Text(S.of(context).correct_option_label),
            onPressed: () {
              Navigator.of(context).pop(QuestionOption.CORRECT);
            },
          ),
          SimpleDialogOption(
            child: Text(S.of(context).incorrect_option_label),
            onPressed: () {
              Navigator.of(context).pop(QuestionOption.INCORRECT);
            },
          ),
        ],
      ),
    );
  }
}
