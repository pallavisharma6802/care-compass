import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CalorieTrackerApp());
}

class CalorieTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalorieTrackerPage(),
      theme: ThemeData(
        primaryColor: primary,
        hintColor: white.withOpacity(0.7),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: white),
          bodyText2: TextStyle(color: white),
          headline6: TextStyle(color: primary),
        ),
      ),
    );
  }
}

class CalorieTrackerPage extends StatefulWidget {
  @override
  _CalorieTrackerPageState createState() => _CalorieTrackerPageState();
}

class _CalorieTrackerPageState extends State<CalorieTrackerPage> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  double _bmrResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Calorie Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
                controller: _weightController, label: 'Weight (kg)'),
            _buildInputField(
                controller: _heightController, label: 'Height (cm)'),
            _buildInputField(controller: _ageController, label: 'Age'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _calculateBMR();
              },
              style: ElevatedButton.styleFrom(
                primary: secondary,
              ),
              child: Text(
                'Calculate BMR',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'BMR Result: $_bmrResult calories/day',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required TextEditingController controller, required String label}) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, secondary],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(color: white),
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            labelStyle: TextStyle(color: white),
            hintStyle: TextStyle(color: white.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }

  void _calculateBMR() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;
    int age = int.tryParse(_ageController.text) ?? 0;

    if (weight > 0 && height > 0 && age > 0) {
      double bmr = calculateBMR(weight, height, age);
      setState(() {
        _bmrResult = bmr;
      });
    } else {
      // Handle invalid input
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: black,
            title: Text(
              'Invalid Input',
              style: TextStyle(color: primary),
            ),
            content:
                Text('Please enter valid values for weight, height, and age.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: primary),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  double calculateBMR(double weight, double height, int age) {
    // BMR calculation formula (Harris-Benedict equation)
    return 655 + 9.6 * weight + 1.8 * height - 4.7 * age;
  }
}
