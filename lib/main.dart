import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:schoollearning/generated/l10n.dart';
import 'package:schoollearning/localization/lang_helper.dart';
import 'package:schoollearning/pages/login_signin_page/welcomePage.dart';
import 'package:schoollearning/routes/route_names.dart';
import 'package:schoollearning/notifiers/loading_notifier.dart';
import 'package:schoollearning/notifiers/logging_page_notifier.dart';
import 'package:schoollearning/pages/main_page/main_page.dart';
import 'package:schoollearning/routes/route-generator.dart';
import 'package:schoollearning/notifiers/auth_notifier.dart';
import 'package:schoollearning/notifiers/page_notifier.dart';
import 'api/app_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'localization/lang_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => AuthNotifier(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => PageNotifier(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => LoggingPageNotifier(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => LoadingNotifier(),
          ),
        ],
        child: MyApp(),
      ));
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  Future<FirebaseApp> initializeFlutterFire() async {
    FirebaseApp app = await Firebase.initializeApp();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    await initializeCurrentUser(authNotifier);
    return app;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFlutterFire(),
        builder: (context, snapshot){
          if(snapshot.hasError) {
            throw('error during init');
          }
          if(snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'BrainUp:Quiz',
              theme: ThemeData(
                primarySwatch: Colors.orange,
                accentColor: Colors.orange,
                buttonTheme: ButtonThemeData(minWidth: 0),
                canvasColor: Colors.blueGrey,
                inputDecorationTheme: InputDecorationTheme(
                  focusColor: Colors.orange,
                  hoverColor: Colors.orange,
                  labelStyle: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.orangeAccent, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.blueGrey[700], width: 1.0),
                  ),
                ),
              ),
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: routeStart,
              debugShowCheckedModeBanner: false,
              supportedLocales: S.delegate.supportedLocales,
              locale: _locale,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],

              localeResolutionCallback: (locale, supportedLocales) {
                for(var supportedLocale in supportedLocales){
                  if(supportedLocale.languageCode == locale.languageCode)
                    return supportedLocale;
                }
                return supportedLocales.first;
              },
            );
          }
          return Container(
            color: Colors.white,
          );
        }
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Consumer<AuthNotifier>(
          builder: (context, notifier, child) {
            if(!notifier.isInitialized)
              return Container(
                color: Colors.blueGrey,
                child: SpinKitWave(
                  size: 90,
                  color: Colors.orange,
                ),
              );

            return notifier.user != null ? MainPage() : WelcomePage();
          },
        ),

        Consumer<LoadingNotifier>(
          builder: (context, notifier, child) {
            return notifier.isLoading ? Container(
              color: Colors.black26.withOpacity(0.5),
              child: Center(
                child: SpinKitPouringHourglass(
                  color: Colors.orange,
                  size: 90,
                ),
              ),
            ):Container();
          },
        ),
      ],
    );
  }
}