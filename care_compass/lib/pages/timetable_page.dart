import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  final TextEditingController _contentController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  List<TimetableItem> _timetableItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Timetable'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddItemButton(context),
              SizedBox(height: 16),
              _buildTimetableList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddItemButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showAddItemDialog(context);
      },
      style: ElevatedButton.styleFrom(
        primary: primary,
      ),
      child: Text(
        'Add Item',
        style: TextStyle(
          color: black,
        ),
      ),
    );
  }

  Widget _buildTimetableList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _timetableItems.map((item) {
        return ListTile(
          title: Text(item.content),
          subtitle: Text(
            'Date: ${_formatDate(item.dateTime)}\nTime: ${_formatTime(item.dateTime)}',
          ),
        );
      }).toList(),
    );
  }

  Future<void> _showAddItemDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: black,
          title: Text(
            'Add Timetable Item',
            style: TextStyle(color: secondary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _contentController,
                style: TextStyle(color: white),
                decoration: InputDecoration(labelText: 'Content'),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(primary: primary),
                    child: Text(
                      'Select Date',
                      style: TextStyle(color: white),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    style: ElevatedButton.styleFrom(primary: primary),
                    child: Text(
                      'Select Time',
                      style: TextStyle(color: white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addItem();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(primary: secondary),
              child: Text(
                'Add',
                style: TextStyle(color: white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _addItem() {
    String content = _contentController.text.trim();
    if (content.isNotEmpty) {
      setState(() {
        _timetableItems.add(TimetableItem(
          type: TimetableItemType.Reminder,
          content: content,
          dateTime: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute,
          ),
        ));
      });

      // Clear text field
      _contentController.clear();
    }
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  String _formatTime(DateTime dateTime) {
    String minuteStr =
        dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
    return "${dateTime.hour}:$minuteStr";
  }
}

class TimetableItem {
  final TimetableItemType type;
  final String content;
  final DateTime dateTime;

  TimetableItem({
    required this.type,
    required this.content,
    required this.dateTime,
  });
}

enum TimetableItemType {
  Reminder,
  Task,
  Deadline,
}

void main() {
  runApp(
    MaterialApp(
      home: TimetablePage(),
    ),
  );
}
