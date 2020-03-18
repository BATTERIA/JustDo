import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_do/src/todo.dart';
import 'package:just_do/src/todo_page.dart';

void main() {
  Hive.init('just_do_db');
  Hive.registerAdapter(TodoListAdapter());
  Hive.registerAdapter(TodoAdapter());
  debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JustDo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'todos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: TodoPage()),
    );
  }
}
