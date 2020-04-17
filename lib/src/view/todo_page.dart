import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/view/common/edit_dialog.dart';
import 'package:just_do/src/entity/todo.dart';
import 'package:just_do/src/view/todo_list_view.dart';

import '../storage/list_storage.dart';

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
          key: Key('todo_list'),
          todos: todos,
          editTodo: editTodo,
          addTodo: addTodo,
          deleteFunction: deleteTodo,
          editTask: editTask,
          addTask: addTask,
          deleteTask: deleteTask,
        ),
      ],
    );
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
    _listStorage.save(todos);
  }

  void addTodo() {
    EditDialog(onConfirm: (content) {
      setState(() {
        todos.add(
          Todo(
            content,
            formatDate(DateTime.now(), [
              yyyy,
              "-",
              mm,
              "-",
              dd,
            ]),
            <Task>[],
          ),
        );
      });
      _listStorage.save(todos);
      Navigator.pop(context);
    }).show(context);
  }

  void editTodo(int index) {
    EditDialog(
      onConfirm: (content) {
        setState(() {
          final todo = todos[index];
          todos[index] = Todo(
            content,
            formatDate(DateTime.now(), [
              yyyy,
              "-",
              mm,
              "-",
              dd,
            ]),
            todo.tasks,
          );
        });
        _listStorage.save(todos);
        Navigator.pop(context);
      },
      defaultText: todos[index].content,
    ).show(context);
  }

  Future<Task> addTask(int index) async {
    Task task;
    await EditDialog(onConfirm: (content) {
      setState(() {
        task = Task(
          content,
          formatDate(DateTime.now(), [
            yyyy,
            "-",
            mm,
            "-",
            dd,
          ]),
        );
        todos[index].tasks.add(task);
      });
      _listStorage.save(todos);
      Navigator.pop(context);
    }).show(context);
    return task;
  }

  Future<Task> editTask(int index, int taskIndex) async {
    Task task;
    await EditDialog(
      onConfirm: (content) {
        setState(() {
          task = Task(
            content,
            formatDate(DateTime.now(), [
              yyyy,
              "-",
              mm,
              "-",
              dd,
            ]),
          );
          todos[index].tasks[taskIndex] = task;
        });
        _listStorage.save(todos);
        Navigator.pop(context);
      },
      defaultText: todos[index].tasks[taskIndex].content,
    ).show(context);
    return task;
  }

  void deleteTask(int index, int taskIndex) {
    setState(() {
      todos[index].tasks.removeAt(taskIndex);
    });
    _listStorage.save(todos);
  }

  @override
  void dispose() {
    super.dispose();
    _listStorage.save(todos);
  }
}
