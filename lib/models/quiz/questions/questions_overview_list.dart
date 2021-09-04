import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/question_overview_card.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import '../../ui_helper.dart';
import '../quiz.dart';

class QuestionsOverviewList extends StatefulWidget {
  @override
  _QuestionsOverviewListState createState() => _QuestionsOverviewListState();
}

class _QuestionsOverviewListState extends State<QuestionsOverviewList> {
  Quiz quiz;
  AuthNotifier authNotifier;

  @override
  Widget build(BuildContext context) {
    quiz = Provider.of<Quiz>(context);
    authNotifier = Provider.of<AuthNotifier>(context);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return questionCard(index, context);
        },
        childCount: quiz.questions.length,
      ),
    );
  }

  Widget questionCard(index, context){
    if(authNotifier.user.username == quiz.author){
      return editingQuestionCard(index, context);
    }else return overviewQuestionCard(index, context);
  }

  Widget overviewQuestionCard(index, context) {
    if(!authNotifier.user.userData.completedQuizData.containsKey(quiz.id)) return  Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Card(
        elevation: 4,
        color: Colors.blueGrey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: Text('№${index+1}:  ???'),
        ),
      ),
    );

    else return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Card(
        elevation: 4,
        color: Colors.blueGrey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: QuestionOverviewCard(index : index, quiz: quiz, isEditable: false,),
        ),
      ),
    );
  }


  Widget editingQuestionCard(
      int index, BuildContext context) =>
      Dismissible(
        background: UIHelper.deleteBg(),
        direction: DismissDirection.startToEnd,
        key: Key(UniqueKey().toString()),
        onDismissed: (direction){
          removeQuestion(index);
        },

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Card(
            elevation: 4,
            color: Colors.blueGrey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(6.0),
                child: QuestionOverviewCard(index : index, quiz: quiz, isEditable: true,),
            ),
          ),
        ),
      );

  removeQuestion(index){
    showOptionDeletedSnackBar(quiz.questions[index], index);
    quiz.questions.removeAt(index);
  }

  showOptionDeletedSnackBar(value, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).question_deleted_label),
      action: SnackBarAction(
        label: S.of(context).cancel_label,
        onPressed: (){
          setState(() {
            quiz.questions.insert(index, value);
          });
        },
      ),
    ));
  }
}
