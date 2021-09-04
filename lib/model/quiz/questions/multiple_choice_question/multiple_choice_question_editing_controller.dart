import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/model/quiz/questions/question.dart';
import 'package:schoollearning/model/ui_helper.dart';

import 'multiple_choice_question.dart';

enum QuestionOption {
  CORRECT,
  INCORRECT,
}

class MultipleChoiceQuestionEditingList extends StatefulWidget {
  @override
  _MultipleChoiceQuestionEditingListState createState() =>
      _MultipleChoiceQuestionEditingListState();
}

class _MultipleChoiceQuestionEditingListState
    extends State<MultipleChoiceQuestionEditingList> {
  MultipleChoiceQuestion question;

  removeOption(index, type) {
    setState(() {
      if (type == QuestionOption.INCORRECT){
        showOptionDeletedSnackBar(context, question.options[index], index, type);
        question.options.removeAt(index);
      }
      else{
        showOptionDeletedSnackBar(context, question.correctOptions[index], index, type);
        question.correctOptions.removeAt(index);
      }
    });
  }

  showOptionDeletedSnackBar(context, value, index, optionType) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).option_deleted_label),
      action: SnackBarAction(
        label: S.of(context).cancel_label,
        onPressed: (){
          setState(() {
            if(optionType == QuestionOption.INCORRECT)
              question.options.insert(index, value);
            else question.correctOptions.insert(index, value);
          });
        },
      ),
    ));
  }

  Widget multipleChoiceQuestionOption(
      BuildContext context, int index, QuestionOption type) {
    String labelText = type == QuestionOption.INCORRECT
        ? S.of(context).incorrect_option_label
        : S.of(context).correct_option_label;

    String initialValue = type == QuestionOption.INCORRECT
        ? question.options[index]
        : question.correctOptions[index];

    TextEditingController editingController = TextEditingController();
    editingController.text = initialValue;

    return Dismissible(
      background: UIHelper.deleteBg(),
      direction: DismissDirection.startToEnd,
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        removeOption(index, type);
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
                  decoration: InputDecoration(labelText: labelText),
                  validator: (String value) {
                    if (value.trim().isEmpty)
                      return S.of(context).field_cant_be_empty_label;
                    return null;
                  },
                  onSaved: (String newValue) {
                    if (type == QuestionOption.INCORRECT)
                      question.options[index] = newValue;
                    else
                      question.correctOptions[index] = newValue;
                  },
                  onEditingComplete: () {
                    if (type == QuestionOption.INCORRECT)
                      question.options[index] =
                          editingController.text;
                    else
                      question.correctOptions[index] =
                          editingController.text;

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
    question =
        Provider.of<Question>(context) as MultipleChoiceQuestion;

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
              initialValue: question.correctOptions.first,
              validator: (String value) {
                if (value.trim().isEmpty)
                  return S.of(context).field_cant_be_empty_label;
                return null;
              },
              onSaved: (String newValue) {
                question.correctOptions[0] = newValue;
              },
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) =>
              multipleChoiceQuestionOption(
                  context, index + 1, QuestionOption.CORRECT),
          itemCount: question.correctOptions.length - 1,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) =>
              multipleChoiceQuestionOption(
                  context, index, QuestionOption.INCORRECT),
          itemCount: question.options.length,
        )
      ],
    );
  }
}
