import 'package:flutter/material.dart';
import 'package:password_generator/Pages/Home.dart';
import 'package:password_generator/Pages/Settings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/settings':
        //The type must be a map
        if (args is Map) {
          //The arguments must be booleans
          if (args['includeNumbers'] is bool &&
              args['includeSymbols'] is bool &&
              args['length'] is int) {
            return MaterialPageRoute(
              builder: (_) => Settings(
                includeNumbers: args['includeNumbers'],
                includeSymbols: args['includeSymbols'],
                length: args['length'],
              ),
            );
          }
        }
        return _errorRoute();
      default: //Handle wrong routes
        return _errorRoute();
    }
  }

  ///Page generated when a wrong route is given to RouteGenerator
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Error page not found"),
            centerTitle: true,
          ),
          body: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning,
                    size: 30.0,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Pagina non esistente",
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
