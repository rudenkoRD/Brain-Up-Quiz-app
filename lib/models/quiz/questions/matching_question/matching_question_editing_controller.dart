import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/quiz/questions/matching_question/matching_question.dart';
import 'package:schoollearning/models/ui_helper.dart';

import '../question.dart';

class MatchingQuestionEditingList extends StatefulWidget {
  @override
  _MatchingQuestionEditingListState createState() =>
      _MatchingQuestionEditingListState();
}

class _MatchingQuestionEditingListState
    extends State<MatchingQuestionEditingList> {
  MatchingQuestion question;
  String keyChangingError;


  @override
  Widget build(BuildContext context) {
    question = Provider.of<Question>(context) as MatchingQuestion;
    keyChangingError = S.of(context).field_should_be_unique;

    return Column(
      children: <Widget>[
        mainMatchingQuestionOption(),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: matchingQuestionOption,
          itemCount: question.questionOptions.length - 1,
        )
      ],
    );

  }

  removeOption(index) {
    showOptionDeletedSnackBar(context, question.answers[index], index);
    setState(() {
      question.answers.removeAt(index);
    });
  }

  showOptionDeletedSnackBar(context, value, index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text( S.of(context).option_deleted_label),
      action: SnackBarAction(
        label: S.of(context).cancel_label,
        onPressed: (){
          setState(() {
            question.answers.insert(index, value);
          });
        },
      ),
    ));
  }

  Widget mainMatchingQuestionOption() {
    String key = question.questionOptions[0];
    String value = question.answerOptions[0];
    TextEditingController keyEditingController =
        new TextEditingController();
    TextEditingController valueEditingController =
        new TextEditingController();
    keyEditingController.text = key;
    valueEditingController.text = value;
    bool isShowingKeyChangingError = false;

    return Card(
      color: Colors.blueGrey[300],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextFormField(
                maxLength: 100,
                controller: keyEditingController,
                decoration: InputDecoration(
                  labelText: S.of(context).option_label,
                  errorMaxLines: 2
                ),
                validator: (String value) {
                  if (value.trim().isEmpty)
                    return S.of(context).field_cant_be_empty_label;
                  return null;
                },
                onSaved: (String newValue) {
                  question.answers[0].first = newValue;
                },
                onEditingComplete: () {
                  question.answers[0].second = valueEditingController.text;
                  question.answers[0].first = keyEditingController.text;
                  WidgetsBinding.instance.focusManager.primaryFocus
                      ?.unfocus();
                },
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                maxLength: 100,
                decoration: InputDecoration(
                  labelText: S.of(context).answer_label,
                  errorText: isShowingKeyChangingError
                      ? keyChangingError
                      : null,
                  errorMaxLines: 3,
                ),
                controller: valueEditingController,
                validator: (String value) {
                  if (value.trim().isEmpty)
                    return S.of(context).field_cant_be_empty_label;

                  bool isDuplicateQuestionOption = false;
                  List<String> options = question.questionOptions;
                  for(int i = 1; i < options.length; i++){
                    if(options[i] == value){
                      isDuplicateQuestionOption = true;
                      break;
                    }
                  }
                  if(isDuplicateQuestionOption)
                    return S.of(context).field_should_be_unique;
                  return null;
                },
                onSaved: (String newValue) {
                  question.answers[0].second = newValue;
                },
                onEditingComplete: () {
                  question.answers[0].first = keyEditingController.text;
                  question.answers[0].second =
                      valueEditingController.text;

                  WidgetsBinding.instance.focusManager.primaryFocus
                      ?.unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget matchingQuestionOption(context, index) {
    String key = question.questionOptions[index + 1];
    String value = question.answerOptions[index + 1];

    TextEditingController keyEditingController =
        new TextEditingController();
    TextEditingController valueEditingController =
        new TextEditingController();
    keyEditingController.text = key;
    valueEditingController.text = value;
    bool isShowingKeyChangingError = false;

    return Dismissible(
      background: UIHelper.deleteBg(),
      direction: DismissDirection.startToEnd,
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        removeOption(index + 1);
      },
      child: Card(
        color: Colors.blueGrey[300],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: keyEditingController,
                  maxLength: 100,
                  decoration: InputDecoration(
                    labelText: S.of(context).option_label,
                    helperText:
                        S.of(context).leave_blank_for_other_answer,
                    helperMaxLines: 4,
                    errorMaxLines: 2
                  ),
                  validator: (String value) {
                    return null;
                  },
                  onSaved: (String newValue) {
                    question.answers[index + 1].first = newValue;
                  },
                  onEditingComplete: () {
                    question.answers[index + 1].second =
                        valueEditingController.text;
                    question.answers[index + 1].first = keyEditingController.text;

                    WidgetsBinding.instance.focusManager.primaryFocus
                        ?.unfocus();
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: valueEditingController,
                  maxLength: 100,
                  decoration: InputDecoration(
                    labelText: S.of(context).answer_label,
                    errorText: isShowingKeyChangingError
                        ? keyChangingError
                        : null,
                    errorMaxLines: 3,
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty)
                      return S.of(context).field_cant_be_empty_label;

                    bool isDuplicateQuestionOption = false;
                    List<String> options = question.questionOptions;
                    for(int i = 0; i < options.length; i++){
                      if(i != index+1 && options[i].trim().toLowerCase() == value.trim().toLowerCase()){
                        isDuplicateQuestionOption = true;
                        break;
                      }
                    }
                    if(isDuplicateQuestionOption)
                      return S.of(context).field_should_be_unique;

                    return null;
                  },
                  onSaved: (String newValue) {
                    question.answers[index + 1].second = newValue;
                  },
                  onEditingComplete: () {
                    question.answers[index + 1].first = keyEditingController.text;
                    question.answers[index + 1].second =
                        valueEditingController.text;

                    WidgetsBinding
                        .instance.focusManager.primaryFocus
                        ?.unfocus();
                  },
                ),
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
}
