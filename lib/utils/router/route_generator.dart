import 'package:axis_assignment/ui/modules/landing/landing_page.dart';
import 'package:axis_assignment/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint('Route to: ${settings.name}');
    switch (settings.name) {
      /// Landing Pages
      case RouteNames.rLandingPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.rLandingPage),
          builder: (_) => const LandingPage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(S.of(context)!.errorMessage)),
        );
      },
    );
  }
}
