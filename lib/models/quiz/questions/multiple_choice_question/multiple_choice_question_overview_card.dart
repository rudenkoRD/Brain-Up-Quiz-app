import 'dart:math';

import 'package:flutter/material.dart';
import 'multiple_choice_question.dart';

class MultipleChoiceQuestionOptionsOverview extends StatelessWidget {
  final MultipleChoiceQuestion question;
  final bool isEditable;

  const MultipleChoiceQuestionOptionsOverview(
      {Key key, @required this.question, @required this.isEditable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> optionStrings = List.from(question.options);
    List<String> correctOptionStrings = List.from(question.correctOptions);
    if (!isEditable) {
      Random rnd = Random(1234);
      optionStrings.shuffle(rnd);
      correctOptionStrings.shuffle(rnd);
    }

    List<Widget> options = List();
    optionStrings.forEach((element) {
      options.add(Text('${options.length + 1}) $element'));
    });
    correctOptionStrings.forEach((element) {
      options.add(Text(
        '${options.length + 1}) $element',
        style:
            TextStyle(color: isEditable ? Colors.green[800] : Colors.black87),
      ));
    });

    return Column(children: options);
  }
}
