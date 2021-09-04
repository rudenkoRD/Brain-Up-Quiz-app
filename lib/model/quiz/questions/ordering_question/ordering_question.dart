import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/model/quiz/questions/ordering_question/ordering_question_overview_card.dart';
import 'package:schoollearning/model/quiz/questions/question.dart';
import 'package:flutter/material.dart';
import '../question_type.dart';

class OrderingQuestion extends Question {
  List<String> userAnswer = List();
  ScrollController scrollController;


  OrderingQuestion(String question, List<String> correctOrderOfAnswers)
      : super(question, QuestionType.ORDERING, correctOrderOfAnswers);

  OrderingQuestion.blank() : super('', QuestionType.ORDERING, List<String>());

  OrderingQuestion.fromJson(String question, Map data)
      : super(question, QuestionType.ORDERING,
            data['correct_order_of_answers'].cast<String>());

  Map<String, dynamic> toMap() {
    return {'correct_order_of_answers': options};
  }

  // Widget orderingQuestionContent(OrderingQuestion question, int index) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           Text(
  //             '№${index + 1}: расставить в правильном порядке',
  //           ),
  //           InkWell(
  //             child: Icon(
  //               Icons.edit,
  //               color: Colors.blueGrey[700],
  //             ),
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
    scrollController = PrimaryScrollController.of(context) ?? ScrollController();

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
        Text(S.of(context).place_items_in_the_correct_order_label),
        Divider(thickness: 2,),
        Expanded(
          flex: 5,
          child: ReorderableListView(
            scrollController: scrollController,
            children: List.generate(
                userAnswer.length, (index) => optionBuilder(index)),
            onReorder: (oldIndex, newIndex) {
              if(newIndex > oldIndex) newIndex--;
              final String moved = userAnswer.removeAt(oldIndex);
              userAnswer.insert(newIndex, moved);
              updateState();
            },
          ),
        )
      ],
    );
  }

  Widget optionBuilder(index) {
    return Card(
      key: UniqueKey(),
      color: Colors.blueGrey[400],
      margin: EdgeInsets.all(4),
      child: ListTile(
        title: Text(userAnswer[index], maxLines: 10,),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.keyboard_arrow_up,color: Colors.blueGrey[600], size: 15,),
            Icon(Icons.pan_tool,color: Colors.blueGrey[800], size: 15,),
            Icon(Icons.keyboard_arrow_down,color: Colors.blueGrey[600], size: 15,)
          ],
        ),
      ),
    );
  }

  @override
  updateCurrentTestingOptions() {
    userAnswer = List.from(options);
    userAnswer.shuffle();
  }

  @override
  get scoreAvailable => options.length;

  @override
  int checkAnswer() {
    int res = 0;
    for(int i = 0; i < userAnswer.length; i++){
      if(userAnswer[i] == options[i]) res++;
      print('userAnswer: ${userAnswer[i]} - option ${options[i]} - i$i');
    }
    return res;
  }

  @override
  Widget questionOptionsOverview(bool isEditable) {
    return OrderingQuestionOptionsOverview(question: this, isEditable: isEditable,);
  }
}
