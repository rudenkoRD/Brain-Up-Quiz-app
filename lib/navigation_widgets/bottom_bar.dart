import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/models/page.dart';
import 'package:schoollearning/notifiers/page_notifier.dart';

import 'bottom_menu_sheet.dart';

class MyBottomBar extends StatefulWidget {
  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {


  @override
  Widget build(BuildContext context) {
    PageNotifier pageNotifier = Provider.of<PageNotifier>(context);

    return BottomAppBar(
      color: Colors.blueGrey[900],
      notchMargin: 10.0,
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
              onPressed: () {
                if(pageNotifier.currentPage != AppPage.HOME) pageNotifier.setPage(AppPage.HOME);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: pageNotifier.currentPage != AppPage.HOME ? Colors.white : Colors.orange,
                  ),
                  Text(
                      S.of(context).main_screen_title,
                      style: TextStyle(
                        fontSize: 12,
                        color:  pageNotifier.currentPage != AppPage.HOME ? Colors.white : Colors.orange,
                      ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed:() {
                if(pageNotifier.currentPage != AppPage.USER_QUIZ) pageNotifier.setPage(AppPage.USER_QUIZ);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.edit,
                    color: pageNotifier.currentPage != AppPage.USER_QUIZ ? Colors.white : Colors.orange,
                  ),
                  Text(
                    S.of(context).my_tests_bar_title,
                    style: TextStyle(
                      fontSize: 12,
                      color:  pageNotifier.currentPage != AppPage.USER_QUIZ ? Colors.white : Colors.orange,
                    ),
                  )
                ],
              ),
            ),

            TextButton(
              onPressed:() {
                if(pageNotifier.currentPage != AppPage.FEATURED) pageNotifier.setPage(AppPage.FEATURED);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.star,
                    color: pageNotifier.currentPage != AppPage.FEATURED ? Colors.white : Colors.orange,
                  ),
                  Text(
                      S.of(context).favourite_screen_title,
                    style: TextStyle(
                      fontSize: 12,
                      color:  pageNotifier.currentPage != AppPage.FEATURED ? Colors.white : Colors.orange,
                    ),
                  )
                ],
              ),
            ),

            TextButton(
              onPressed:() {
                if(pageNotifier.currentPage != AppPage.SETTINGS) pageNotifier.setPage(AppPage.SETTINGS);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: pageNotifier.currentPage != AppPage.SETTINGS ? Colors.white : Colors.orange,
                  ),
                  Text(
                      S.of(context).settings_screen_title,
                    style: TextStyle(
                      fontSize: 12,
                      color:  pageNotifier.currentPage != AppPage.SETTINGS ? Colors.white : Colors.orange,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}