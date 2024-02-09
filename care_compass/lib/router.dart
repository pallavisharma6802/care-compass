import 'package:care_compass/pages/bmi.dart';
import 'package:care_compass/pages/calorie_tracker.dart';
import 'package:care_compass/pages/chat.dart';
import 'package:care_compass/pages/login_page.dart';
import 'package:care_compass/pages/notes_page.dart';
import 'package:care_compass/pages/profile_page.dart';
import 'package:care_compass/pages/root_app.dart';
import 'package:care_compass/pages/symptom_diagnosis.dart';
import 'package:care_compass/pages/timetable_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings setting) {
  final Map<String, dynamic> args = new Map<String, dynamic>();

  switch (setting.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginPage());

    case '/root_app':
      return MaterialPageRoute(builder: (context) => RootApp());

    case '/bmi':
      return MaterialPageRoute(builder: (context) => BmiPage());

    case '/calorie_tracker':
      return MaterialPageRoute(builder: (context) => CalorieTrackerApp());

    case '/symptom_diagnosis':
      return MaterialPageRoute(builder: (context) => SymptomDiagnosisPage());

    case '/chat':
      return MaterialPageRoute(builder: (context) => ChatPage());

    case '/notes':
      return MaterialPageRoute(builder: (context) => NotesPage());

    case '/timetable':
      return MaterialPageRoute(builder: (context) => TimetablePage());

    case '/profile':
      return MaterialPageRoute(builder: (context) => ProfilePage());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(),
        ),
      );
  }
}
