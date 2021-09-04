import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/model/quiz/questions/question.dart';
import 'package:flutter/material.dart';
import 'package:schoollearning/model/quiz/questions/single_choice_question/single_choice_question_overview_card.dart';
import '../question_type.dart';

class SingleChoiceQuestion extends Question {
  String _correctAnswer;
  List<String> _currentTestingOptions = List();
  String _selectedAnswer = '';

  SingleChoiceQuestion(
      String question, List<String> options, String correctAnswer)
      : super(question, QuestionType.SINGLE_CHOICE, options) {
    this._correctAnswer = correctAnswer;
  }

  SingleChoiceQuestion.blank() : super(' ', QuestionType.SINGLE_CHOICE, []) {
    _correctAnswer = '';
  }

  @override
  SingleChoiceQuestion.fromJson(String question, Map data)
      : super(question, QuestionType.SINGLE_CHOICE,
            data['options'].cast<String>()) {
    _correctAnswer = data['correct_answer'];
  }

  String get correctAnswer => _correctAnswer;

  set correctAnswer(newValue) => _correctAnswer = newValue;

  @override
  updateCurrentTestingOptions() {
    _currentTestingOptions.clear();
    options.forEach((option) {
      _currentTestingOptions.add(option);
    });
    _currentTestingOptions.add(correctAnswer);
    _currentTestingOptions.shuffle();
  }

  @override
  int checkAnswer() {
    if (_selectedAnswer.isEmpty) return -1;

    if (_selectedAnswer == _correctAnswer)
      return 1;
    else
      return 0;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'correct_answer': _correctAnswer,
      'options': options,
    };
  }

  // Widget questionOptionCardContent(int index) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Text('№${index + 1}'),
  //       Text(options[index]),
  //       Row(
  //         children: <Widget>[
  //           Icon(
  //             Icons.edit,
  //           ),
  //           Icon(
  //             Icons.delete,
  //             color: Colors.red[300],
  //           )
  //         ],
  //       )
  //     ],
  //   );
  // }

  @override
  testingWidget(Function() callback, context) {
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
        Text(S.of(context)
            .select_one_correct_answer_label),
        Divider(
          thickness: 2,
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              color: Colors.blueGrey[400],
              child: RadioListTile(
                groupValue: _selectedAnswer,
                onChanged: (newValue) {
                  _selectedAnswer = newValue;
                  callback();
                },
                value: _currentTestingOptions[index],
                title: Text(
                  _currentTestingOptions[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            itemCount: _currentTestingOptions.length,
          ),
        )
      ],
    );
  }

  @override
  get scoreAvailable => 1;

  // @override
  // Widget questionTaskContent(int index) =>
  //     _SingleChoiceTaskContent(this, index);

  @override
  Widget questionOptionsOverview(bool isEditable) =>
      SingleChoiceOptionsOverview(
        question: this,
        isEditable: isEditable,
      );
}

// class SingleChoiceTaskContent extends StatelessWidget {
//   final SingleChoiceQuestion question;
//   final int index;
//
//   SingleChoiceTaskContent(this.question, this.index);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text(
//               '№${index + 1}:   ${AppLocalizations.of(context).translate('single_choice_question_label')}',
//             ),
//             Row(
//               children: <Widget>[
//                 InkWell(
//                   child: Icon(
//                     Icons.edit,
//                     color: Colors.blueGrey[700],
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(context, routeEditQuizTask,
//                         arguments: question);
//                   },
//                 ),
//                 InkWell(
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.red[400],
//                   ),
//                   onTap: () {
//                     Scaffold.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(AppLocalizations.of(context)
//                             .translate('use_double_tap_to_delete_label')),
//                       ),
//                     );
//                   },
//                 )
//               ],
//             )
//           ],
//         ),
//         Divider(),
//         Text(
//           question.question,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         Divider(),
//         QuestionUi.showAnswerOptions(question),
//       ],
//     );
//   }
// }
