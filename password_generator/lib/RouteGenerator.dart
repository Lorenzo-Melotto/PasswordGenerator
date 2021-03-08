import 'package:flutter/material.dart';
import 'package:password_generator/Pages/Home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return _errorRoute();
    }
  }

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
