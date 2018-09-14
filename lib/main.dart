import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_stresstest/application.dart';
import 'package:flutter_api_stresstest/routes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter API stresstest",
      onGenerateRoute: Application.router.generator,
    );
  }
}
