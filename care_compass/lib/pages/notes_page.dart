import 'package:care_compass/theme/colors.dart';
import 'package:flutter/material.dart';

class Note {
  String title;
  String content;

  Note({required this.title, required this.content});
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddNoteDialog(context);
              },
              style: ElevatedButton.styleFrom(
                primary: secondary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    color: black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add Note',
                    style: TextStyle(color: black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            if (notes.isNotEmpty) ...[
              Text(
                'Previous Notes:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Container(
                  color: black,
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return _buildNoteCard(notes[index]);
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: primary,
      child: ListTile(
        title: Text(
          note.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: black,
          ),
        ),
        subtitle: Text(
          note.content,
          style: TextStyle(
            color: white,
          ),
        ),
      ),
    );
  }

  Future<void> _showAddNoteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: black,
          title: Text(
            'Add New Note',
            style: TextStyle(
              color: secondary,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(
                  color: white,
                ),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _contentController,
                style: TextStyle(
                  color: white,
                ),
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: primary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addNewNote();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: primary,
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  color: black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addNewNote() {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      setState(() {
        notes.add(Note(title: title, content: content));
      });

      // Clear text fields
      _titleController.clear();
      _contentController.clear();
    }
  }
}

void main() {
  runApp(
    MaterialApp(
      home: NotesPage(),
    ),
  );
}
