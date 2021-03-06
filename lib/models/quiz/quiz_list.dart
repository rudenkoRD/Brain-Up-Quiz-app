import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/page.dart';
import 'package:schoollearning/notifiers/page_notifier.dart';
import 'package:schoollearning/routes/route_names.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'quiz.dart';
import 'package:schoollearning/services/firestore_database.dart';

class QuizList extends StatefulWidget {

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {

  List quizList;

  @override
  void initState() {
    //loadUserQuizList();
    super.initState();
  }

  FirestoreService db = FirestoreService();
  AuthNotifier authNotifier;
  Stream<List<Quiz>> stream;
  StreamSubscription subscription;

  loadQuizList() {
     stream = db.getQuizList();

    subscription = stream.listen((List<Quiz> data) {
      if(mounted) {
        setState(() {
          quizList = data;
        });
      }
    });
  }

  loadUserQuizList() {
    stream = db.getUsersQuizList(authNotifier.user);

    subscription = stream.listen((List<Quiz> data) {
      if(mounted) {
        setState(() {
          quizList = data;
        });
      }
    });
  }

  loadFeaturedQuizList(){
    stream = db.getFeaturedQuizList(authNotifier.user.userData.featuredIds);

    subscription = stream.listen((List<Quiz> data) {
      if(mounted) {
        setState(() {
          quizList = data;
        });
      }
    });
  }


  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    PageNotifier pageNotifier = Provider.of<PageNotifier>(context);
    switch(pageNotifier.currentPage){
      case AppPage.HOME : {
        loadQuizList();
        break;
      }
      case AppPage.USER_QUIZ: {
        loadUserQuizList();
        break;
      }
      case AppPage.FEATURED : {
        loadFeaturedQuizList();
        break;
      }
    }

    // return FutureBuilder(
    //     future: loadData(),
    //     builder: (context, snapshot){
    //       if(snapshot.hasError){
    //         throw('error during loading quiz list');
    //       }
    //       if(snapshot.connectionState == ConnectionState.done){
    //         return Container(
    //             color: Colors.blueGrey,
    //             child: ListView.builder(
    //               itemBuilder: (context, i) => _testItem(i, context),
    //               itemCount: quizList.length,
    //             ));
    //       }
    //       return Container(
    //         color: Colors.blueGrey,
    //         child: SpinKitCircle(
    //           color: Colors.orange,
    //         ),
    //       );
    //     },
    // );

    if(quizList == null){
      return Container(
        child: SpinKitCircle(color: Colors.orange)
      );
    }else if(quizList.length == 0){
      return Container(
        child: Center(
          child: Text(
              S.of(context).empty_label,
              style: TextStyle(
                fontSize: 20,
              ),
          ),
        ),
      );
    }else {
      return Container(
        color: Colors.blueGrey,
        child: ListView.builder(
          itemBuilder: (context, i) => _testItem(i, context),
          itemCount: quizList.length,
        ));
    }
  }

  Widget _testItem(int index, BuildContext context) {
    return Card(
      elevation: 3.0,
      color: Colors.blueGrey[300],
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(routeQuizOverview,
                  arguments: quizList[index]);
            },
            title: Text(
              quizList[index].title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900]),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            leading: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: InkWell(
                      child: Icon(
                        authNotifier.user.userData.featuredIds.contains(quizList[index].id)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber[600],
                      ),
                      onTap: () async{
                        setState(() {
                          if(authNotifier.user.userData.featuredIds.contains(quizList[index].id)){
                            authNotifier.user.userData.featuredIds.remove(quizList[index].id);
                          }else authNotifier.user.userData.featuredIds.add(quizList[index].id);
                        });
                        await FirestoreService().addOrUpdateUserData(authNotifier.user);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.thumbs_up_down,
                          color: Colors.blueGrey[800],
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          quizList[index].positiveMarks.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          quizList[index].negativeMarks.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.red[600],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            subtitle: lessonSubtitle(context, quizList[index])),
      ),
    );
  }
}



Widget lessonSubtitle(BuildContext context, Quiz test) {
  var color = translatePercentToColor(test.difficulty.toInt());
  var indicatorLevel = test.completedTimes != 0 ? (100 - test.difficulty) / 100 : 0.0;

  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: LinearProgressIndicator(
          backgroundColor: Colors.blueGrey,
          value: indicatorLevel,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        flex: 1,
        child: Text(
          test.difficultyTitle(context),
          style: TextStyle(color: Colors.blueGrey[900]),
        ),
      ),
    ],
  );
}

Color translatePercentToColor(int value) {
  int red = 0;
  int green = 0;
  const blue = 20;

  if (value <= 50) {
    red = 255;
    green = (255 * value) ~/ 50;
  } else {
    red = (255 * (100 - value)) ~/ 40;
    green = 255;
  }

  return Color.fromRGBO(red, green, blue, 1);
}
