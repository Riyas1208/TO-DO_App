import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../database/model/data_model.dart';

class DeleteTaskPage extends StatelessWidget {
  final int taskIndex;

  DeleteTaskPage(this.taskIndex);

  @override
  Widget build(BuildContext context) {
    final Task? task = Hive.box<Task>('tasks').getAt(taskIndex);

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/a.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Do you want to delete this task?',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Title: ${task?.title}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                'Description: ${task?.description}',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _deleteTask(context);
                },
                child: Text('Delete Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    final box = Hive.box<Task>('tasks');
    box.deleteAt(taskIndex);
    Navigator.of(context).pop();
  }
}
