import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../database/model/data_model.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/a.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                style: TextStyle(color: Colors.white), // Set the text color to white
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                style: TextStyle(color: Colors.white), // Set the text color to white
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Back'),
                  ),
                  SizedBox(width: 20), // Adjust the width as needed for spacing
                  ElevatedButton(
                    onPressed: () {
                      _saveTask(context);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask(BuildContext context) {
    final title = titleController.text;
    final description = descriptionController.text;

    if (title.isNotEmpty) {
      final task = Task(title, description, false);
      final box = Hive.box<Task>('tasks');
      box.add(task);
      Navigator.of(context).pop();
    }
  }
}
