import 'package:flutter/material.dart';
import 'package:schoollearning/model/quiz/questions/question.dart';

class QuestionUi {
  static Widget showAnswerOptions(Question question) {
    List<Widget> optionsWidgetList = List();
    List<String> shuffledAnswerOptions = List.from(question.options);
    shuffledAnswerOptions.shuffle();
    for (int i = 0; i < shuffledAnswerOptions.length; i++) {
      optionsWidgetList.add(
          questionAnswerOption(i, shuffledAnswerOptions[i], true));
    }
    return Column(
      children: optionsWidgetList,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  static Widget questionAnswerOption(
      int index, String option, bool isNumericIndexing) {
    if (isNumericIndexing)
      return Text('${index + 1})  $option');
    else
      return Text('${String.fromCharCode(index + 97)})  $option');
  }

  // static Widget questionCard(
  //         int index, Question question, BuildContext context) =>
  //     Container(
  //       padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
  //       child: Card(
  //         elevation: 4,
  //         color: Colors.blueGrey[200],
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15.0),
  //         ),
  //         child: Container(
  //           padding: EdgeInsets.all(6.0),
  //           child: question.questionTaskContent(index),
  //         ),
  //       ),
  //     );
  //
  // static Widget taskOptionCard(int index, Question question) =>
  //     Container(
  //       child: Card(
  //         elevation: 4,
  //         color: Colors.blueGrey[200],
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         child: Container(
  //           padding: EdgeInsets.all(6.0),
  //           child: question.questionOptionCardContent(index),
  //         ),
  //       ),
  //     );
}
