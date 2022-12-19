import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_rp/model/todo.dart';
import 'package:todo_app_rp/screen/archievescreen.dart';
import 'package:todo_app_rp/screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ToDo> toodo = <ToDo>[];

  setupTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    print(stringTodo);
    List todoList = jsonDecode(stringTodo!);

    for (var todo in todoList) {
      // setState(() {
      toodo.add(
          ToDo(id: (todo["id"]), todoText: todo["todoText"]).fromJson(todo));
      // });
    }
/*
    for (var todo in todoList) {
      setState(() {
        toodo.add(
            ToDo(id: (todo["id"]), todoText: todo["todoText"]).fromJson(todo));
      });
    }
    */
  }

  saveTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List items = toodo.map((e) => e.toJson()).toList();
    //  prefs.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

/*
class MyApp extends StatelessWidget {
  List<ToDo> toodo = <ToDo>[];

/*
   setupTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringTodo = prefs.getString('todo');
    print(stringTodo);
    List todoList = jsonDecode(stringTodo!);

    for (var todo in todoList) {
      setState(() {
        widget.todosList.add( ToDo(id: (todo["id"]), todoText: todo["todoText"]).fromJson(todo));
      });
    }
  }

  saveTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List items = widget.todosList.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }
  */

  */
  @override
  Widget build(BuildContext context) {
    print('main build2');
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ToDo App'),
            centerTitle: true,
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: const Color.fromARGB(255, 127, 132, 129)),
              tabs: [
                const Tab(
                    icon: Icon(Icons.document_scanner),
                    text: "ToDo Item Screen"),
                const Tab(icon: Icon(Icons.archive), text: "Archieve Screen")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Home(
                todosList: toodo,
                onSave: saveTodo,
              ),
              AchievementScreen(
                todosList: toodo,
                onSave: saveTodo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}  

/*
import 'package:flutter/material.dart';
//import 'package:todo_app_rp/model/todo.dart';
import 'package:todo_app_rp/screen/home.dart';

import 'model/todo.dart';

void main() {
  runApp(MyApp());
  print('abc');
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  List<ToDo> toodo = <ToDo>[];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('main');
    return MaterialApp(
        title: 'ToDoApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(todosList: toodo));
  }
}
*/