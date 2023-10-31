import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/model/data_model.dart';
import 'Add_Task.dart';
import 'Delete_Task.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, d MMMM');
    return formatter.format(now);
  }

  void _navigateToDeleteTaskScreen(BuildContext context, int taskIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeleteTaskPage(taskIndex),
      ),
    );
  }

  void _deleteTask(int index) {
    Hive.box<Task>('tasks').deleteAt(index);
  }

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
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Column(
                children: [
                  Text(
                    'My Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getFormattedDate(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<Task>>(
                valueListenable: Hive.box<Task>('tasks').listenable(),
                builder: (context, box, _) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final task = box.getAt(index);
                      return Card(
                        elevation: 4,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/task.png',
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            task!.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            task.description,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) {
                                  setState(() {
                                    task.isCompleted = value!;
                                    task.save();
                                  });
                                },
                              ),
                              Text(
                                task.isCompleted ? 'Completed' : 'Pending',
                                style: TextStyle(
                                  color: task.isCompleted ? Colors.green : Colors.red,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteTask(index);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            _navigateToDeleteTaskScreen(context, index);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
