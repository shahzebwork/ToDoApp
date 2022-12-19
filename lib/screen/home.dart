import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_rp/constant/colors.dart';
import 'package:todo_app_rp/widgets/todo_item.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  List<ToDo> todosList;
  final onSave;
  Home({
    super.key,
    required this.todosList,
    this.onSave,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final List <ToDo> todosList = <ToDo>todoList;
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

  // List<ToDo> todosList = <ToDo>[
  //  ToDo(id: 1, todoText: 'Morning Walk', isDone: true),
  //  ToDo(id: 2, todoText: 'Breakfast', isDone: true),
  //ToDo(id: 3, todoText: 'Getting ready for office'),
  // ];

  final _todoController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _addToDoItem(String toDo) {
    setState(() {
      widget.todosList
          .add(ToDo(id: DateTime.now().millisecondsSinceEpoch, todoText: toDo));
      widget.onSave();
    });
    _todoController.clear();
  }

  void _completeToDoItem(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      widget.onSave();
    });
  }

  void _archieveToDoItem(ToDo todo) {
    setState(() {
      todo.isArchieve = !todo.isArchieve;
      widget.onSave();
    });
  }

  void _deleteToDoItem(int id) {
    setState(() {
      widget.todosList.removeWhere((item) => item.id == id);
      widget.onSave();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('home build');
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
          child: ListView(
            children: [
              Card(
                elevation: 8,
                child: SizedBox(
                  // width: double.infinity,
                  //  height: 175,
                  child: Column(children: [
                    Card(
                      color: tdGrey,
                      child: Row(
                        //    mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.add_box_rounded,
                            color: tdBlue,
                            size: 45.0,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'ADD ITEM',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'What you want to add',
                        ),
                      ),
                    ),
                    Row(children: [
                      Expanded(
                        child: Form(
                          key: _formkey,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: tdBGColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _todoController,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(200),
                              ],
                              //  readOnly: isReadOnly,
                              minLines: 1,
                              maxLines: 2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannnot be empty';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Add a new todo Item',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        width: 55,
                        margin: const EdgeInsets.only(bottom: 10, right: 10),
                        child: FloatingActionButton(
                          onPressed: (() {
                            setState(() {
                              if (_formkey.currentState!.validate()) {
                                _addToDoItem(_todoController.text);
                              }
                            });
                          }),
                          child: const Text(
                            '+',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      )
                    ]),
                  ]),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 8,
                child: SizedBox(
                  // width: double.infinity,
                  height: 230,
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
                              Icons.add_business_rounded,
                              color: tdOrange,
                              size: 45.0,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'TODO LIST',
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
                              if (todoo.isDone == false &&
                                  todoo.isArchieve == false)
                                ToDoItem(
                                  todo: todoo,
                                  onCompleteItem: _completeToDoItem,
                                  onDeleteItem: _deleteToDoItem,
                                  onSave: widget.onSave,
                                  onArchieveItem: _archieveToDoItem,
                                  // onUndoItem:_undoToDoItem,
                                )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 8,
                child: SizedBox(
                  height: 230,
                  child: Column(
                    children: [
                      Card(
                        color: tdGrey,
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.domain_add_rounded,
                              color: tdgreen,
                              size: 45.0,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'COMPLETED',
                              style: TextStyle(color: tdWhite, fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // height: 175,
                        child: ListView(children: [
                          for (ToDo todoo in widget.todosList.reversed)
                            if (todoo.isDone)
                              ToDoItem(
                                todo: todoo,
                                onCompleteItem: _completeToDoItem,
                                onDeleteItem: _deleteToDoItem,
                              )
                        ]),
                      )
                    ],
                  ),
                ),
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
import 'package:flutter/services.dart';
import 'package:todo_app_rp/constant/colors.dart';
import 'package:todo_app_rp/widgets/todo_item.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();

  final _todoController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
      //    _runfilter();
    });
    _todoController.clear();
  }

  void _editToDoItem(ToDo todo) {
    setState(() {
      _todoController = todo.todoText.toString();
    });
  }

  void _completeToDoItem(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ToDoApp'),
          centerTitle: true,
          backgroundColor: tdBlue,
          elevation: 5,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              Card(
                elevation: 8,
                child: SizedBox(
                  // width: double.infinity,
                  //  height: 175,
                  child: Column(children: [
                    Card(
                      color: tdGrey,
                      child: Row(
                        //    mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.add_box_rounded,
                            color: tdBlue,
                            size: 45.0,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'ADD ITEM',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'What you want to add',
                        ),
                      ),
                    ),
                    Row(children: [
                      Expanded(
                        child: Form(
                          key: _formkey,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: tdBGColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _todoController,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(200),
                              ],
                              minLines: 1,
                              maxLines: 2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field cannnot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Add a new todo Item',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        width: 55,
                        margin: EdgeInsets.only(bottom: 10, right: 10),
                        child: FloatingActionButton(
                          onPressed: (() {
                            setState(() {
                              if (_formkey.currentState!.validate()) {
                                _addToDoItem(_todoController.text);
                              }
                            });
                          }),
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      )
                    ]),
                  ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 8,
                child: SizedBox(
                  // width: double.infinity,
                  height: 230,
                  child: Column(
                    children: [
                      Card(
                        color: tdGrey,
                        child: Row(
                          //    mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.add_business_rounded,
                              color: tdOrange,
                              size: 45.0,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'TODO LIST',
                              style: TextStyle(color: tdWhite, fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // height: 175,
                        child: ListView(
                          children: [
                            for (ToDo todoo in todosList.reversed)
                              if (todoo.isDone == false)
                                ToDoItem(
                                  todo: todoo,
                                  onCompleteItem: _completeToDoItem,
                                  onDeleteItem: _deleteToDoItem,
                                  onEditItem: _editToDoItem,
                                )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              /*   
              Card(
                elevation: 8,
                child: SizedBox(
                  // width: double.infinity,
                  height: 230,
                  child: Column(
                    children: [
                      Card(
                        color: tdGrey,
                        child: Row(
                          //    mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.add_business_rounded,
                              color: tdOrange,
                              size: 45.0,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'TODO LIST',
                              style: TextStyle(color: tdWhite, fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // height: 175,
                        child: ListView(
                          children: [
                            for (ToDo todoo in todosList.reversed)
                              ToDoItem(
                                todo: todoo,
                                onCompleteItem: _completeToDoItem,
                                onDeleteItem: _deleteToDoItem,
                                onEditItem: _editToDoItem,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              */
              SizedBox(
                height: 15,
              ),
              Card(
                child: SizedBox(
                  height: 230,
                  child: Column(
                    children: [
                      Card(
                        color: tdGrey,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.domain_add_rounded,
                              color: tdgreen,
                              size: 45.0,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'COMPLETED',
                              style: TextStyle(color: tdWhite, fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // height: 175,
                        child: ListView(children: [
                          for (ToDo todoo in todosList.reversed)
                            if (todoo.isDone!)
                              ToDoItem(
                                todo: todoo,
                                onCompleteItem: _completeToDoItem,
                                onDeleteItem: _deleteToDoItem,
                                onEditItem: _editToDoItem,
                              )
                        ]),
                      )
                    ],
                  ),
                ),
                elevation: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// This is final
*/
 


//        SizedBox(
//       width: double.infinity,
//     height: 200,
//    child:
//  ),
// );

/*
              Card(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 55.0,
                    maxHeight: 230.0,
                  ),
                  child: Column(
                    children: [
                      Card(
                        color: tdGrey,
                        child: Row(
                          //    mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.add_business_rounded,
                              color: tdBlue,
                              size: 45.0,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'COMPLETED',
                              style: TextStyle(color: tdWhite, fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                          constraints: BoxConstraints(
                            minHeight: 0.0,
                            maxHeight: 10.0,
                          ),
                          child: ListView(
                            children: [
                              ToDoItem(),
                            ],
                          ))
                    ],
                  ),
                ),
                elevation: 8,
              ),

              */

/*
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Icon(
                                  Icons.check,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  //size: 54,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 20,
                                child: Text(
                                    'Dont forget to buy foodfffffffffffffffffffffffffffffffffffffffff'),
                              ),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.edit, color: Colors.green)),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ]),
                          ),
                        ),
                        */

/*
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Icon(
                                  Icons.check,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  //size: 54,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 20,
                                child: Text(
                                    'Dont forget to buy foodfffffffffffffffffffffffffffffffffffffffff'),
                              ),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.edit, color: Colors.green)),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ]),
                          ),
                        ),
                        */

/*
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text('What you want to add'),
                                Container(
                                  child: TextFormField(),
                                )
                              ],
                              
                            ),
                          ),

                          Container(
                            child: FloatingActionButton(
                              onPressed: () {},
                              child: Text('+'),
                            ),
                          ),
                          
                        ],
                      ),
                    )
                    */

/*
                        //  padding: EdgeInsets.only(right: 10),
                        //  decoration: BoxDecoration(
                        //    color: tdBlue,
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        //  padding: EdgeInsets.only(right: 10),
                       
                        child: ElevatedButton(
                          onPressed: (() {
                            /*  setState(() {
                        if (_formkey.currentState!.validate()) {
                          _addToDoItem(_todoController.text);
                        }
                      });*/
                          }),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 40,
                              color: tdWhite,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: 
                          ),
                        ),
                        
                      */
