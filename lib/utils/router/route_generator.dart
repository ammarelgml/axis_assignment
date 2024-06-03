import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/ui/modules/people/details/person_details_page.dart';
import 'package:axis_assignment/ui/modules/people/index/people_page.dart';
import 'package:axis_assignment/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint('Route to: ${settings.name}');
    switch (settings.name) {
      /// People Pages
      case RouteNames.rPeoplePage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.rPeoplePage),
          builder: (_) => const PeoplePage(),
        );

      case RouteNames.rPeopleDetailsPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.rPeopleDetailsPage),
          builder: (_) => PersonDetailsPage(people: settings.arguments as People),
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
