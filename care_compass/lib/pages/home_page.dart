import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

class Article {
  String title;
  String description;

  Article({required this.title, required this.description});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget buildListItem({
    required String title,
    required String description,
    required String imagePath,
    required String routeName,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(colors: [secondary, primary]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 95,
              height: 45,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [fourthColor, thirdColor]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, routeName);
                  },
                  child: Text(
                    "Check",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [fourthColor, thirdColor]),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 17,
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "A M I G O !!!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: fourthColor),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              buildListItem(
                title: "BodySync",
                description:
                    "BMI is a measure of body fat based on your weight and height. You have a normal weight.",
                imagePath: 'assets/images/bmi.png',
                routeName: '/bmi',
              ),
              buildListItem(
                title: "CalorEase",
                description:
                    "Track your daily calorie intake, gain insights into your nutritional habits, and achieve your wellness goals.",
                imagePath: 'assets/images/calorie.png',
                routeName: '/calorie_tracker',
              ),
              buildListItem(
                title: "SymptoScan",
                description:
                    "Instantly assess symptoms with our Symptom Diagnoser for quick health insights.",
                imagePath: 'assets/images/diagnosis.png',
                routeName: '/symptom_diagnosis',
              ),
              buildListItem(
                title: "MediChat",
                description:
                    "Chat seamlessly with our intelligent virtual assistant, DoctorGPT, for expert medical advice and support.",
                imagePath: 'assets/images/chat.png',
                routeName: '/chat',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
