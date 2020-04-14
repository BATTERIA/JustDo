import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/card_view.dart';

import 'add_card.dart';
import 'todo.dart';

typedef DeleteFunction = Function(int index);

class TodoListView extends StatefulWidget {
  const TodoListView({
    Key key,
    this.todos,
    this.addTodo,
    this.deleteFunction,
    this.editTodo,
    this.addTask,
    this.deleteTask,
    this.editTask,
  }) : super(key: key);

  final DeleteFunction deleteFunction;

  final Function addTodo;

  final List<Todo> todos;

  final EditCallback editTodo;
  final Function addTask;
  final Function deleteTask;
  final Function editTask;

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  int get size => widget.todos.length;

  @override
  Widget build(BuildContext context) {
    final todos = <Todo>[];

    todos.addAll(widget.todos);

    todos.add(Todo('', '', []));

    return ReorderableListView(
      padding: EdgeInsets.only(top: 25),
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
      children: todos.map((todo) {
        final index = todos.indexOf(todo);
        if (index + 1 == todos.length) {
          return GestureDetector(
            key: ValueKey(todo),
            child: AddCard(
              content: '添加新的Todo项',
            ),
            onTap: widget.addTodo,
          );
        }
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
          tasks: todo.tasks,
          editTask: widget.editTask,
          addTask: widget.addTask,
          deleteTask: widget.deleteTask,
        );
      }).toList(),
    );
  }
}
