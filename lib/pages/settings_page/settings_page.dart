import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/api/app_api.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/localization/lang_constants.dart';
import 'package:schoollearning/models/page.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/notifiers/page_notifier.dart';

import '../../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var value = false;
  AuthNotifier authNotifier;
  PageNotifier pageNotifier;
  Locale currentLocale;

  void _changeLanguage(Locale locale) async {
    Locale _locale = await setLocale(locale.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  void initState() {
    loadCurrentLocale();
    super.initState();
  }

  Future loadCurrentLocale() async {
    currentLocale = await getLocale();
  }

  Future<Locale> showChangeLocaleDialog(context) async {
    return showDialog<Locale>(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.blueGrey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Text(S.of(context).select_lang_label),
        children: <Widget>[
          SimpleDialogOption(
            child: Text(S.of(context).english_lang_label),
            onPressed: () {
              Navigator.of(context).pop(Locale('en', 'US'));
            },
          ),
          SimpleDialogOption(
            child: Text(S.of(context).russian_lang_label),
            onPressed: () {
              Navigator.of(context).pop(Locale('ru', 'RU'));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    pageNotifier = Provider.of<PageNotifier>(context);

    return FutureBuilder(
      future: loadCurrentLocale(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw ('error during init');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height,
            color: Colors.blueGrey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Text(
                      S.of(context).general_label,
                      style: TextStyle(color: Colors.orange, fontSize: 18.0, fontWeight: FontWeight.bold, shadows: [
                        Shadow(color: Colors.black38, blurRadius: 1.0, offset: Offset(1.0, 1.0)),
                      ]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      onTap: () {
                        showChangeLocaleDialog(context).then((newLocale) {
                          _changeLanguage(newLocale);
                        });
                      },
                      leading: Icon(
                        Icons.language,
                        //color: Theme.of(context).accentColor,
                      ),
                      title: Text(
                        S.of(context).language_label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.blueGrey[900],
                          shadows: [
                            Shadow(color: Colors.black12, offset: Offset(0.5, 0.5)),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        '${S.of(context).current_lang_label}: ${getNameOfLangByLocale(currentLocale, context)}',
                        style: TextStyle(
                          shadows: [
                            Shadow(color: Colors.black12, offset: Offset(0.5, 0.5)),
                          ],
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.blueGrey[700],
                  ),
                  Container(
//            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: ListTile(
                      leading: Text(
                        S.of(context).notifications_label,
                        style: TextStyle(color: Colors.orange, fontSize: 18.0, fontWeight: FontWeight.bold, shadows: [
                          Shadow(color: Colors.black38, blurRadius: 1.0, offset: Offset(1.0, 1.0)),
                        ]),
                      ),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.access_time,
                        //color: Theme.of(context).accentColor,
                      ),
                      title: Text(
                        S.of(context).time_label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.blueGrey[900],
                          shadows: [
                            Shadow(color: Colors.black12, offset: Offset(0.5, 0.5)),
                          ],
                        ),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Text(
                          '19:00',
                          style: TextStyle(
                            shadows: [
                              Shadow(color: Colors.black12, offset: Offset(0.5, 0.5)),
                            ],
                          ),
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.blueGrey[700],
                  ),
                  Container(
//            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: ListTile(
                      leading: Text(
                        '${S.of(context).account_label}:   ${authNotifier.user.username}',
                        style: TextStyle(color: Colors.orange, fontSize: 18.0, fontWeight: FontWeight.bold, shadows: [
                          Shadow(color: Colors.black38, blurRadius: 1.0, offset: Offset(1.0, 1.0)),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      onTap: exitAccount,
                      leading: Icon(
                        Icons.exit_to_app,
                        //color: Theme.of(context).accentColor,
                      ),
                      title: Text(
                        S.of(context).exit_label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.blueGrey[900],
                          shadows: [
                            Shadow(color: Colors.black12, offset: Offset(0.5, 0.5)),
                          ],
                        ),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  void featuredSettingsTap(bool value) {
    setState(() {
      this.value = value;
    });
  }

  void exitAccount() {
    signout(authNotifier);
    pageNotifier.setPage(AppPage.HOME);
  }

  String getNameOfLangByLocale(Locale locale, context){
    switch(locale.languageCode) {
      case 'ru' : return S.of(context).russian_lang_label;
      case 'en' : return S.of(context).english_lang_label;
      default: throw('locale isn\'t supported');
    }
  }
}
