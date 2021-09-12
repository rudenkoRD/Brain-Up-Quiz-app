import 'package:flutter/material.dart';
import 'package:schoollearning/main.dart';
import 'package:schoollearning/models/quiz/questions/question.dart';
import 'package:schoollearning/models/quiz/quiz.dart';
import 'package:schoollearning/pages/home_page/home_page.dart';
import 'package:schoollearning/pages/base/my_page.dart';
import 'package:schoollearning/pages/question_editing_page/question_editing_page.dart';
import 'package:schoollearning/pages/quiz_overiew_page/quiz_overview_page.dart';
import 'package:schoollearning/pages/quiz_result_page/quiz_result_page.dart';
import 'package:schoollearning/pages/testing_page/testing_page.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object args = settings.arguments;

    switch (settings.name) {
      case routeQuizOverview:
        if (args is Quiz) {
          return MaterialPageRoute(
              builder: (_) => MyPage(screenContentWidget: QuizOverviewPage(args)));
        } else
          return null;
        break;
      case routeEditQuizTask:
        if (args is Question) {
          return MaterialPageRoute(
              builder: (_) => MyPage(screenContentWidget:TaskEditingPage(args)));
        } else
          return null;
        break;

      case routeTesting:
        if(args is Quiz) {
          return MaterialPageRoute(
            builder: (_) => MyPage(screenContentWidget: TestingPage(args))
          );
        }else return null;
        break;

      case routeQuizResult:
        if(args is List){
          return MaterialPageRoute(
            builder: (_) => MyPage(screenContentWidget: QuizResultPage(args[0] as double, args[1] as Quiz))
          );
        }else return null;
        break;

      case routeStart:
        return MaterialPageRoute(
          builder: (_) => MyPage(screenContentWidget: StartPage(),)
        );
        break;

      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
