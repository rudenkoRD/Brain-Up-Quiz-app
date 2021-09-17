import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/localization/lang_helper.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/notifiers/page_notifier.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthNotifier authNotifier;
  PageNotifier pageNotifier;
  LangHelper langHelper;


  @override
  void initState() {
    langHelper = new LangHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authNotifier = Provider.of<AuthNotifier>(context);
    pageNotifier = Provider.of<PageNotifier>(context);

    return FutureBuilder(
      future: langHelper.loadCurrentLocale(),
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
                  generalSettings(context),
                  Divider(
                    thickness: 2.0,
                    color: Colors.blueGrey[700],
                  ),
                  accountSettings(context),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget generalSettings(context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      generalLabel(context),
      langSettings(context),
    ],
  );

  Widget generalLabel(context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    child: Text(
      S.of(context).general_label,
      style: TextStyle(color: Colors.orange, fontSize: 18.0, fontWeight: FontWeight.bold,
        shadows: [
          Shadow(color: Colors.black38, blurRadius: 1.0, offset: Offset(1.0, 1.0)),
        ],
      ),
    ),
  );

  Widget langSettings(context) => Container(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: ListTile(
      onTap: (){
        showChangeLocaleDialog(context);
      },
      leading: Icon(Icons.language),
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
        '${S.of(context).current_lang_label}: ${langHelper.getNameOfLangByLocale(context)}',
        style: TextStyle(
          shadows: [
            Shadow(color: Colors.black12, offset: Offset(0.5, 0.5)),
          ],
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
    ),
  );


  Widget accountSettings(context) => Column(
    children: [
      accountLabel(context),
      logOutButton(context),
    ],
  );

  Widget accountLabel(context) => Container(
    child: ListTile(
      leading: Text(
        '${S.of(context).account_label}:   ${authNotifier.user.username}',
        style: TextStyle(color: Colors.orange, fontSize: 18.0, fontWeight: FontWeight.bold, shadows: [
          Shadow(color: Colors.black38, blurRadius: 1.0, offset: Offset(1.0, 1.0)),
        ]),
      ),
    ),
  );

  Widget logOutButton(context) => Container(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: ListTile(
      onTap: (){
        authNotifier.exitAccount(pageNotifier);
      },
      leading: Icon(
        Icons.exit_to_app,
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
  );


  void showChangeLocaleDialog(context){
    openLocaleDialog(context).then((newLocale) {
      langHelper.changeLanguage(newLocale, context);
    });
  }

  Future<Locale> openLocaleDialog(context) async {
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
}
