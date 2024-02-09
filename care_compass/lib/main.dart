import 'package:care_compass/pages/root_app.dart';
import 'package:flutter/material.dart';

import 'router.dart' as router;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login', // Set the initial route to '/login'
    home: RootApp(),
    onGenerateRoute: router.generateRoute,
  ));
}
