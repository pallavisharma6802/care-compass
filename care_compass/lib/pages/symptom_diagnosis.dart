import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

class SymptomDiagnosisPage extends StatefulWidget {
  @override
  _SymptomDiagnosisPageState createState() => _SymptomDiagnosisPageState();
}

class _SymptomDiagnosisPageState extends State<SymptomDiagnosisPage> {
  TextEditingController _queryController = TextEditingController();
  List<String> symptomHistory = [];
  List<Threat> possibleThreats = [];

  @override
  void initState() {
    super.initState();
    _showInitialPopup();
  }

  void _showInitialPopup() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: black,
            title: Text(
              'SymptoScan',
              style: TextStyle(color: primary),
            ),
            content: Text(
              'Let\'s shine bright today and conquer everything!!',
              style: TextStyle(color: white),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: secondary,
                ),
                child: Text(
                  'Got it!',
                  style: TextStyle(color: white),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: Text(
          'Symptom Diagnosis',
          style: TextStyle(color: primary),
        ),
        backgroundColor: black,
      ),
      drawer: buildHistoryDrawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildQueryField(),
          _buildPossibleThreats(),
        ],
      ),
    );
  }

  Widget _buildQueryField() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: bgTextField,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _queryController,
            decoration: InputDecoration(
              hintText: 'Enter your symptoms...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _diagnoseSymptoms();
            },
            style: ElevatedButton.styleFrom(
              primary: primary,
            ),
            child: Text(
              'Diagnose',
              style: TextStyle(color: black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPossibleThreats() {
    if (possibleThreats.isNotEmpty) {
      return Expanded(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              'Possible Threats:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            SizedBox(height: 8.0),
            for (Threat threat in possibleThreats)
              _buildThreat(threat.name, threat.percentage),
          ],
        ),
      );
    } else {
      return Container(); // Empty container if there are no threats to display
    }
  }

  Widget _buildThreat(String threatName, int percentage) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            threatName,
            style: TextStyle(
              color: white,
              fontSize: 16.0,
            ),
          ),
          Text(
            '$percentage%',
            style: TextStyle(
              color: white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHistoryDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primary,
            ),
            child: Center(
              child: Text(
                'Symptom History',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          for (String symptom in symptomHistory)
            ListTile(
              title: Text(
                symptom,
                style: TextStyle(color: black),
              ),
              onTap: () {
                // Handle tapping on symptom history
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }

  void _diagnoseSymptoms() {
    String query = _queryController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        symptomHistory.add(query);
      });

      // Implement symptom diagnosis logic here
      // For demonstration, let's just update the UI with some sample threats
      possibleThreats = [
        Threat(name: 'Sample Threat 1', percentage: 80),
        Threat(name: 'Sample Threat 2', percentage: 60),
        Threat(name: 'Sample Threat 3', percentage: 40),
      ];

      // Clear the input field
      _queryController.clear();
    }
  }
}

class Threat {
  final String name;
  final int percentage;

  Threat({required this.name, required this.percentage});
}

void main() {
  runApp(
    MaterialApp(
      home: SymptomDiagnosisPage(),
    ),
  );
}
