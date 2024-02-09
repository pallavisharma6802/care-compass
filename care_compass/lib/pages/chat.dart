import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _queryController = TextEditingController();
  List<Message> messages = [
    Message(sender: 'DoctorAI', content: 'Let\'s rock today!'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Bar (Similar to SymptomDiagnosisPage)
          Container(
            width: 250,
            color: primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Chat History',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Patient 1',
                    style: TextStyle(color: white),
                  ),
                  onTap: () {
                    _loadChatHistory('Patient 1');
                  },
                ),
                ListTile(
                  title: Text(
                    'Patient 2',
                    style: TextStyle(color: white),
                  ),
                  onTap: () {
                    _loadChatHistory('Patient 2');
                  },
                ),
                // Add more patients as needed
              ],
            ),
          ),

          // Chat Content Area
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text('Chat with Doctor'),
                backgroundColor: primary,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black, // Set the background color here
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return _buildMessage(messages[index]);
                        },
                      ),
                    ),
                  ),
                  _buildInputArea(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    return Align(
      alignment:
          message.sender == 'DoctorAI' ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: message.sender == 'DoctorAI' ? primary : fourthColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: white),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: bgTextField,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _queryController,
              decoration: InputDecoration(
                hintText: 'Type your query...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              _sendMessage();
            },
            style: ElevatedButton.styleFrom(
              primary: primary,
            ),
            child: Text(
              'Send',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void _loadChatHistory(String patientName) {
    setState(() {
      messages = [
        Message(
            sender: 'DoctorAI',
            content: 'Hello, $patientName! How can I help you today?'),
      ];
    });
  }

  void _sendMessage() {
    String query = _queryController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        messages.add(Message(sender: 'User', content: query));
      });

      // Simulate a delayed response from the doctor
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          messages.add(Message(
              sender: 'DoctorAI', content: 'Sure! Let me check that for you.'));
        });
      });

      _queryController.clear();
    }
  }
}

class Message {
  final String sender;
  final String content;

  Message({required this.sender, required this.content});
}

void main() {
  runApp(
    MaterialApp(
      home: ChatPage(),
    ),
  );
}
