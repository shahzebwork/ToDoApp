import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_rp/model/todo.dart';

import '../constant/colors.dart';

class ToDoItem extends StatefulWidget {
  final ToDo todo;
  final onCompleteItem;
  final onDeleteItem;
  final onSave;
  final onArchieveItem;
  final onUndoItem;
//  final onEditItem;
  // final onCancelItem;
  final onSaveItem;

  const ToDoItem({
    super.key,
    required this.todo,
    this.onCompleteItem,
    this.onDeleteItem,
    this.onSave,
    this.onArchieveItem,
    this.onUndoItem,
    this.onSaveItem,

    //this.onEditItem,
    //  this.onCancelItem,
    //  this.onSaveItem,
  });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  final _todoEditController = TextEditingController();
  bool onReadOnly = true;
  Color onTodoColor = tdWhite;
  final GlobalKey<FormState> _formkey_1 = GlobalKey<FormState>();

  void _onEditItem(String todoo) {
    setState(() {
      onReadOnly = false;
      onTodoColor = tdBGColor;
      _todoEditController.text = todoo;
    });
  }

  void _onCancelItem() {
    setState(() {
      onReadOnly = true;
      onTodoColor = tdWhite;
    });
  }

  void _onSaveItem(ToDo toDo) {
    setState(() {
      onReadOnly = true;
      onTodoColor = tdWhite;
      toDo.todoText = _todoEditController.text;
      widget.onSave();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("todoitem build");
    return Card(
      elevation: 2,
      child: ListTile(
        //  padding: const EdgeInsets.all(5.0),
        leading: onReadOnly
            ? widget.todo.isDone
                ? null
                : ElevatedButton(
                    onPressed: () {
                      widget.onCompleteItem(widget.todo);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(5),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  )
            : null,
        title: onReadOnly
            ? Text(widget.todo.todoText)
            : Expanded(
                // child: Form(
                //  key: _formkey_1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: onTodoColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formkey_1,
                    child: TextFormField(
                      controller: _todoEditController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(200),
                      ],
                      readOnly: onReadOnly,
                      minLines: 1,
                      maxLines: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field cannnot be empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        // hintText: 'widget.todo.todoText',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                // ),
              ),

        trailing: SizedBox(
          width: 120,
          child: onReadOnly
              ? widget.todo.isArchieve
                  ? SizedBox(
                      // width: 40,
                      child: IconButton(
                        onPressed: () {
                          widget.onUndoItem(widget.todo);
                        },
                        icon: const Icon(
                          Icons.undo,
                          color: tdGrey,
                        ),
                      ),
                    )
                  : // if The textfield is ReadOnly this part executes
                  Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: widget.todo.isDone
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    _onEditItem(widget.todo.todoText);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: tdgreen,
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: 40,
                          child: IconButton(
                            onPressed: (() {
                              widget.onDeleteItem(widget.todo.id);
                            }),
                            icon: const Icon(
                              Icons.delete,
                              color: tdRed,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: widget.todo.isDone
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    widget.onArchieveItem(widget.todo);
                                  },
                                  icon: const Icon(
                                    Icons.archive,
                                    color: tdGrey,
                                  ),
                                ),
                        ),
                      ],
                    )
              : Row(
                  // if The textfield is not ReadOnly this part executes
                  children: [
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (() {
                          _onCancelItem();
                        }),
                        padding: const EdgeInsets.all(0.0),
                        icon: const Icon(
                          Icons.cancel,
                          color: tdRed,
                          size: 35,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        onPressed: (() {
                          setState(() {
                            if (_formkey_1.currentState!.validate()) {
                              _onSaveItem(widget.todo);
                            }
                          });
                        }),
                        padding: const EdgeInsets.all(0.0),
                        icon: const Icon(
                          Icons.save,
                          color: tdgreen,
                          size: 35,
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
