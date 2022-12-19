import 'package:flutter/material.dart';
import 'package:todo_app_rp/constant/colors.dart';
import 'package:todo_app_rp/widgets/todo_item.dart';
import '../model/todo.dart';

class AchievementScreen extends StatefulWidget {
  List<ToDo> todosList;
  final onSave;
  AchievementScreen({
    super.key,
    required this.todosList,
    this.onSave,
  });

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  //final List <ToDo> todosList = <ToDo>todoList;

  void _undoToDoItem(ToDo todo) {
    setState(() {
      todo.isArchieve = !todo.isArchieve;
      widget.onSave;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Achievement build');
    return SafeArea(
      child: Scaffold(
        /*
        appBar: AppBar(
          title: const Text('ToDoApp'),
          centerTitle: true,
          backgroundColor: tdBlue,
          elevation: 5,
        ),
        */
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Card(
            elevation: 8,
            child: SizedBox(
              // width: double.infinity,

              //  height: 230,
              child: Column(
                children: [
                  Card(
                    color: tdGrey,
                    child: Row(
                      //    mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.archive,
                          color: tdgreen,
                          size: 45.0,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Archieve LIST',
                          style: TextStyle(color: tdWhite, fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    // height: 175,
                    child: ListView(
                      children: [
                        for (ToDo todoo in widget.todosList.reversed)
                          if (todoo.isDone == false && todoo.isArchieve == true)
                            ToDoItem(
                              todo: todoo,
                              // onCompleteItem: _completeToDoItem,
                              onUndoItem: _undoToDoItem,
                              // onSave: saveTodo,
                            )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
