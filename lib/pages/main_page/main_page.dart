import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/models/page.dart';
import 'package:schoollearning/navigation_widgets/bottom_bar.dart';
import 'package:schoollearning/navigation_widgets/floating_action_button.dart';
import 'package:schoollearning/notifiers/page_notifier.dart';
import 'package:schoollearning/services/internet_connection_check.dart';

class MainPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  InternetConnection internetConnection = InternetConnection();

  @override
  void initState() {
    internetConnection.checkConnection(context);
    super.initState();
  }

  @override
  void dispose() {
    internetConnection.listener.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    PageNotifier pageNotifier = Provider.of<PageNotifier>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[900],
          brightness: Brightness.dark,
          title: Text(
            pageNotifier.titleName(context),
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: pageNotifier.pageWidget,
        bottomNavigationBar: MyBottomBar(),
        floatingActionButton: pageNotifier.currentPage == AppPage.USER_QUIZ ? MyFloatingActionButton() : null,
      ),
    );
  }
}
