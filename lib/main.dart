import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_app/screen/List_Task.dart';

import 'database/model/data_model.dart';

// Import your TaskListPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your To-Do App',
      theme: ThemeData(
        primaryColor: Colors.white, // Change the primary color
        hintColor: Colors.white, // Change the accent color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TaskListPage(),
      debugShowCheckedModeBanner: false

    );
  }
}

