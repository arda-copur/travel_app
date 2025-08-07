import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/views/home_view.dart';
import 'package:travel_app/views/login_view.dart';
import 'package:travel_app/views/profile_view.dart';
import 'package:travel_app/views/splash_view.dart';
import 'package:travel_app/views/trip_details_view.dart';

// This class defines the app's routes and provides navigation methods
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String tripDetails = '/tripDetails';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashView(),
      login: (context) => LoginView(),
      home: (context) => const HomeView(),
      profile: (context) => const ProfileView(),
      tripDetails: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        if (args is Travel) {
          return TripDetailsView(trip: args);
        }
        return const Text('Error: Trip not found');
      },
    };
  }

  static void go(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void goAndReplace(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static void goAndRemoveUntil(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false,
        arguments: arguments);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
