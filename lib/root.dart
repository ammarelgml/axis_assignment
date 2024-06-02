import 'package:axis_assignment/utils/constants.dart';
import 'package:axis_assignment/utils/router/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// This widget is the root of your application.
class Root extends StatefulWidget {
  const Root({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  static Locale locale = const Locale('en');

  // Build Number
  static String versionNumber = '';
  static String buildNumber = '';

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Root.navigatorKey,
      title: Constants.appName,
      debugShowCheckedModeBanner: false,

      /// Localization Stuff
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.supportedLocales,
      locale: Root.locale,

      /// Theme Stuff

      /// Routing Stuff
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
