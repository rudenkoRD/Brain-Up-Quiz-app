import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schoollearning/models/quiz/quiz_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Container(

      child: QuizList(false),
        // DraggableScrollableSheet(
        //   minChildSize: 0.08,
        //   maxChildSize: 0.6,
        //   initialChildSize: 0.08,
        //   builder: (context, controller) => Container(
        //     decoration: BoxDecoration(
        //         color: Colors.blueGrey[100],
        //         borderRadius: BorderRadius.only(
        //             topRight: Radius.circular(20.0),
        //             topLeft: Radius.circular(20.0))),
        //     child: Stack(
        //       overflow: Overflow.visible,
        //       children: <Widget>[
        //         ListView(
        //           controller: controller,
        //           children: <Widget>[
        //             Padding(
        //               padding: const EdgeInsets.only(top: 8.0),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: <Widget>[
        //                   Icon(
        //                     Icons.eject,
        //                     color: Colors.orange,
        //                   ),
        //                   SizedBox(width: 10),
        //                   Text(
        //                     S.of(context).my_tests_bar_title,
        //                     style: TextStyle(fontSize: 25),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             Divider(
        //               thickness: 1.5,
        //             ),
        //             ListView.builder(
        //               padding: EdgeInsets.only(top: 8.0),
        //               physics: ClampingScrollPhysics(),
        //               shrinkWrap: true,
        //               itemBuilder: userQuizCard,
        //               itemCount: userQuizList.length,
        //             ),
        //           ],
        //         ),
        //         Positioned(
        //           child: MyFloatingActionButton(),
        //           top: -15,
        //           right: 20,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
    );
  }

  // Widget userQuizCard(context, index) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.0),
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(20))),
  //       elevation: 2.0,
  //       color: Colors.blueGrey[300],
  //       margin: EdgeInsets.all(4.0),
  //       child: ListTile(
  //         onTap: () {
  //           Navigator.pushNamed(context, routeQuizOverview,
  //               arguments: userQuizList[index]);
  //         },
  //         title: Text(
  //           userQuizList[index].title,
  //         ),
  //         trailing: Icon(Icons.keyboard_arrow_right),
  //       ),
  //     ),
  //   );
  // }
}
