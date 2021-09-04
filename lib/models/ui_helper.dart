import 'package:flutter/material.dart';
import 'package:schoollearning/generated/l10n.dart';

class UIHelper{

  static void showSnackBarHelperForDeleting(context){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).swipe_to_delete_label),
    ));
  }

  static Widget deleteBg(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.red.withAlpha(150),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      margin: EdgeInsets.all(6.0),
      child: const Icon(Icons.delete),
    );
  }
}