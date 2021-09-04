import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/ui_helper.dart';

import '../question.dart';
import 'ordering_question.dart';

class OrderingQuestionEditingList extends StatefulWidget {
  @override
  _OrderingQuestionEditingListState createState() =>
      _OrderingQuestionEditingListState();
}

class _OrderingQuestionEditingListState
    extends State<OrderingQuestionEditingList> {
  OrderingQuestion question;

  @override
  Widget build(BuildContext context) {
    question = Provider.of<Question>(context);
    ScrollController scrollController = ScrollController();

    if (question.options.isEmpty) {
      return Text(
        S.of(context).ordering_tutorial,
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
        child: ReorderableColumn(
          mainAxisSize: MainAxisSize.min,
          needsLongPressDraggable: true,
          scrollController: scrollController,
          children: List.generate(question.numberOfOptions,
              (index) => orderingQuestionOption(index)),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              final String moved =
                  question.options.removeAt(oldIndex);
              question.options.insert(newIndex, moved);
            });
          },
        ),
      );
    }
  }

  removeOption(index, context){
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

  Widget orderingQuestionOption(int index) {
    TextEditingController optionEditingController = TextEditingController();
    optionEditingController.text = question.options[index];
    return Dismissible(
      background: UIHelper.deleteBg(),
      direction: DismissDirection.startToEnd,
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        setState(() {
          removeOption(index, context);
        });
      },
      child: Card(
        color: Colors.blueGrey[300],
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  maxLength: 100,
                  decoration: InputDecoration(
                    labelText: '${S.of(context).option_label} ${index + 1}',
                  ),
                  controller: optionEditingController,
                  validator: (String value) {
                    if (value.trim().isEmpty)
                      return S.of(context).field_cant_be_empty_label;
                    return null;
                  },
                  onSaved: (String newValue) {
                    question.options[index] = newValue;
                  },
                  onEditingComplete: (){
                    question.options[index] = optionEditingController.text;
                    WidgetsBinding
                        .instance.focusManager.primaryFocus
                        ?.unfocus();
                  },
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_up,color: Colors.blueGrey[600],),
                  Icon(Icons.pan_tool,color: Colors.blueGrey[800], size: 20,),
                  Icon(Icons.keyboard_arrow_down,color: Colors.blueGrey[600],)
                ],
              ),
              SizedBox(
                width: 10.0,
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
