import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/models/quiz/quiz.dart';
import 'package:schoollearning/models/quiz/quiz_list.dart';
import 'package:schoollearning/routes/route_names.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/services/firestore_database.dart';

class FeaturedPage extends StatefulWidget {
  @override
  _FeaturedPageState createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {

  @override
  Widget build(BuildContext context) {
    return QuizList();
  }

}

