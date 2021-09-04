import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/model/quiz/questions/single_choice_question/single_choice_question.dart';
import 'package:schoollearning/model/ui_helper.dart';

import '../question.dart';

class SingleChoiceQuestionEditingList extends StatefulWidget {
  @override
  _SingleChoiceQuestionEditingListState createState() =>
      _SingleChoiceQuestionEditingListState();
}

class _SingleChoiceQuestionEditingListState
    extends State<SingleChoiceQuestionEditingList> {
  SingleChoiceQuestion question;

  removeOption(index) {
    showOptionDeletedSnackBar(context, question.options[index], index);
    setState(() {
      question.options.removeAt(index);
    });
  }

  showOptionDeletedSnackBar(context, value, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).option_deleted_label),
      action: SnackBarAction(
        label: S.of(context).cancel_label,
        onPressed: (){
          setState(() {
            question.options.insert(index, value);
          });
        },
      ),
    ));
  }



  Widget singleChoiceQuestionOption(BuildContext context, int index) {
    TextEditingController editingController = TextEditingController();
    editingController.text = question.options[index];
    return Dismissible(
      background: UIHelper.deleteBg(),
      direction: DismissDirection.startToEnd,
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        removeOption(index);
      },
      child: Card(
        color: Colors.blueGrey[300],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: TextFormField(
                  controller: editingController,
                  maxLength: 100,
                  decoration: InputDecoration(
                    labelText: S.of(context).incorrect_option_label,
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty)
                      return S.of(context).field_cant_be_empty_label;
                    return null;
                  },
                  onSaved: (String newValue) {
                    question.options[index] = newValue;
                  },
                  onEditingComplete: () {
                    question.options[index] = editingController.text;

                    WidgetsBinding.instance.focusManager.primaryFocus
                        ?.unfocus();
                  },
                ),
              ),
              VerticalDivider(
                thickness: 1.0,
              ),
              InkWell(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.red[400],
                ),
                onTap: (){
                  UIHelper.showSnackBarHelperForDeleting(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    question = Provider.of<Question>(context) as SingleChoiceQuestion;

    return Column(
      children: <Widget>[
        Card(
          color: Colors.blueGrey[300],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              maxLength: 100,
              decoration: InputDecoration(
                labelText: S.of(context).correct_option_label,
              ),
              initialValue: question.correctAnswer,
              validator: (String value) {
                if (value.trim().isEmpty)
                  return S.of(context).field_cant_be_empty_label;
                return null;
              },
              onSaved: (String newValue) {
                question.correctAnswer = newValue;
              },
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: singleChoiceQuestionOption,
          itemCount: question.options.length,
        )
      ],
    );
  }
}
