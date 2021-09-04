import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schoollearning/models/quiz/questions/ordering_question/ordering_question.dart';

class OrderingQuestionOptionsOverview extends StatelessWidget {
  final OrderingQuestion question;
  final bool isEditable;

  const OrderingQuestionOptionsOverview(
      {Key key, @required this.question,@required this.isEditable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> optionStrings = List.from(question.options);
    if (!isEditable) {
      Random rnd = Random(1234);
      optionStrings.shuffle(rnd);
    }

    List<Widget> options = List.generate(question.numberOfOptions,
        (index) => Text('${index + 1}) ${optionStrings[index]}'));

    return Column(children: options);
  }
}
