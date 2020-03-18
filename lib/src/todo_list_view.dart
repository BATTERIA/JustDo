import 'package:flutter/cupertino.dart';
import 'package:just_do/src/card_view.dart';

import 'todo.dart';

typedef DeleteFunction = Function(int index);

class TodoListView extends StatefulWidget {
  const TodoListView({Key key, this.todos, this.deleteFunction}) : super(key: key);

  final DeleteFunction deleteFunction;

  final List<Todo> todos;

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  int get size => widget.todos.length;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: size,
      itemBuilder: (context, index) {
        return CardView(
          deleteItem: () => widget.deleteFunction(index),
          content: widget.todos[index].content,
          dateTime: widget.todos[index].date,
        );
      },
    );
  }
}
