import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schoollearning/model/quiz/questions/single_choice_question/single_choice_question.dart';

class SingleChoiceOptionsOverview extends StatelessWidget {
  final SingleChoiceQuestion question;
  final bool isEditable;
  SingleChoiceOptionsOverview({Key key, @required this.question, @required this.isEditable}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> optionStrings = List.from(question.options);
    optionStrings.add(question.correctAnswer);
    if(!isEditable){
      Random rnd = Random(1234);
      optionStrings.shuffle(rnd);
    }

    List<Widget> options = List.generate(question.numberOfOptions+1, (index) {
      if(index != question.numberOfOptions)
        return Text(
            '${index + 1}) ${optionStrings[index]}'
        );
      else return Text('${index + 1}) ${optionStrings[index]}', style: TextStyle(color: isEditable ? Colors.green[800] : Colors.black87),);
    });


    return Column(
      children: options
    );
  }
}

