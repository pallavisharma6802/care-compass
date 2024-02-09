import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double bmiResult = 0.0;
  String bmiStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInputField(
                'Height (cm)', 'Enter your height', _heightController),
            SizedBox(height: 20),
            _buildInputField(
                'Weight (kg)', 'Enter your weight', _weightController),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _calculateBMI();
              },
              style: ElevatedButton.styleFrom(
                primary: thirdColor,
              ),
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            Text(
              'BMI Result:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              bmiResult.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'BMI Status:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              bmiStatus,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            SizedBox(height: 30),
            _buildBMIInfoTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, String hintText, TextEditingController controller) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, secondary],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: white),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          labelStyle: TextStyle(color: white),
          hintStyle: TextStyle(color: white.withOpacity(0.7)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      double bmi = weight / (heightInMeters * heightInMeters);

      setState(() {
        bmiResult = bmi;
        bmiStatus = _getBMIStatus(bmi);
      });
    }
  }

  String _getBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Healthy Weight';
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  Widget _buildBMIInfoTable() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: bgTextField,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BMI Classification Table:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
          SizedBox(height: 10),
          _buildTableRow('Below 18.5', 'Underweight'),
          _buildTableRow('18.5 – 24.9', 'Healthy Weight'),
          _buildTableRow('25.0 – 29.9', 'Overweight'),
          _buildTableRow('30.0 and Above', 'Obesity'),
        ],
      ),
    );
  }

  Widget _buildTableRow(String range, String weightStatus) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          range,
          style: TextStyle(
            fontSize: 16,
            color: primary,
          ),
        ),
        Text(
          weightStatus,
          style: TextStyle(
            fontSize: 16,
            color: primary,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: BmiPage(),
    ),
  );
}
