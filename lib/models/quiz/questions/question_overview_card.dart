import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:schoollearning/models/quiz/questions/question_type.dart';
import 'package:schoollearning/models/ui_helper.dart';
import 'package:schoollearning/routes/route_names.dart';
import '../quiz.dart';


class QuestionOverviewCard extends StatefulWidget {
  final int index;
  final Quiz quiz;
  final bool isEditable;

  QuestionOverviewCard({this.index, this.quiz, this.isEditable = false});

  @override
  _QuestionOverviewCardState createState() => _QuestionOverviewCardState();
}

class _QuestionOverviewCardState extends State<QuestionOverviewCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '№${widget.index + 1}:   ${widget.quiz.questions[widget.index].type.name(context)}',
            ),
            widget.isEditable ? Row(
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.edit,
                    color: Colors.blueGrey[700],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, routeEditQuizTask,
                        arguments: widget.quiz.questions[widget.index]).then((newQuestion){
                      if(newQuestion != null && newQuestion is Question){
                        setState(() {
                          widget.quiz.questions[widget.index] = newQuestion;
                        });
                      }else print('null');
                    });
                  },
                ),
                InkWell(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red[400],
                  ),
                  onTap: () {
                    UIHelper.showSnackBarHelperForDeleting(context);
                  },
                )
              ],
            ): Container(),
          ],
        ),
        Divider(),
        Text(
          widget.quiz.questions[widget.index].question,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Divider(),
        questionOverviewContent(),
      ],
    );
  }

  Widget questionOverviewContent(){
    return widget.quiz.questions[widget.index].questionOptionsOverview(widget.isEditable);
  }
}
