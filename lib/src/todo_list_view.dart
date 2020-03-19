import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/card_view.dart';

import 'todo.dart';

typedef DeleteFunction = Function(int index);

class TodoListView extends StatefulWidget {
  const TodoListView({Key key, this.todos, this.deleteFunction, this.editTodo})
      : super(key: key);

  final DeleteFunction deleteFunction;

  final List<Todo> todos;

  final EditCallback editTodo;

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  int get size => widget.todos.length;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        print(oldIndex);
        print(newIndex);
        var element = widget.todos[oldIndex];
        if (newIndex >= widget.todos.length) newIndex = widget.todos.length - 1;
        setState(() {
          widget.todos.removeAt(oldIndex);
          widget.todos.insert(newIndex, element);
        });
      },
      children: widget.todos.map((todo) {
        final index = widget.todos.indexOf(todo);
        return CardView(
          key: ValueKey(todo),
          index: index,
          editTodo: widget.editTodo,
          deleteItem: () {
            widget.deleteFunction(index);
            setState(() {});
          },
          content: todo.content,
          dateTime: todo.date,
        );
      }).toList(),
    );
  }
}
