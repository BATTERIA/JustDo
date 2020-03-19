import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/edit_dialog.dart';
import 'package:just_do/src/float_button.dart';
import 'package:just_do/src/todo.dart';
import 'package:just_do/src/todo_list_view.dart';

import 'list_storage.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> todos = <Todo>[];
  ListStorage _listStorage;

  @override
  void initState() {
    super.initState();
    _initTodoList();
  }

  Future<void> _initTodoList() async {
    _listStorage = ListStorage();
    todos = await _listStorage.query();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TodoListView(
          editTodo: editTodo,
          deleteFunction: (index) {
            setState(() {
              todos.removeAt(index);
            });
            _listStorage.save(todos);
          },
          todos: todos,
        ),
        FloatButton(
          onTap: () {
            EditDialog(onConfirm: (content) {
              setState(() {
                todos.add(Todo(
                    content,
                    formatDate(DateTime.now(), [
                      yyyy,
                      "-",
                      mm,
                      "-",
                      dd,
                    ])));
              });
              _listStorage.save(todos);
              Navigator.pop(context);
            }).show(context);
          },
        ),
      ],
    );
  }

  void editTodo(int index) {
    EditDialog(
      onConfirm: (content) {
        setState(() {
          todos[index] = Todo(
              content,
              formatDate(DateTime.now(), [
                yyyy,
                "-",
                mm,
                "-",
                dd,
              ]));
        });
        _listStorage.save(todos);
        Navigator.pop(context);
      },
      defaultText: todos[index].content,
    ).show(context);
  }

  @override
  void dispose() {
    super.dispose();
    _listStorage.save(todos);
  }
}
