import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/jcolors.dart';

import 'small_card_view.dart';
import 'todo.dart';

typedef EditCallback = Function(int index);

class CardView extends StatelessWidget {
  const CardView({
    Key key,
    this.index,
    this.content,
    this.dateTime,
    this.deleteItem,
    this.editTodo,
    this.tasks = const <Task>[],
    this.editTask,
    this.addTask,
    this.deleteTask,
  }) : super(key: key);

  final int index;
  final String content;
  final String dateTime;
  final Function deleteItem;
  final EditCallback editTodo;
  final List<Task> tasks;
  final Function editTask;
  final Function addTask;
  final Function deleteTask;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('key$index'),
      child: buildCardView(content, dateTime, context),
      onDismissed: (_) => deleteItem(),
    );
  }

  Widget buildCardView(String key, String value, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      height: 36,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: JColors.itemColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 5),
              blurRadius: 5.0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: deleteItem,
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.delete_outline,
                          size: 17,
                          color: JColors.deleteIcon,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width - 90,
                      child: GestureDetector(
                        onTap: () => editTodo(index),
                        child: Text(
                          key,
                          style: TextStyle(color: JColors.textColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: deleteItem,
                        child: PopupMenuButton(
                          elevation: 2,
                          padding: EdgeInsets.all(0),
                          tooltip: '拆分todo项',
                          icon: Icon(
                            Icons.details,
                            size: 17,
                            color: JColors.deleteIcon,
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                enabled: false,
                                child: Container(
                                  width: 200,
                                  child: TaskList(
                                    index: index,
                                    content: content,
                                    dateTime: dateTime,
                                    tasks: tasks,
                                    editTask: editTask,
                                    addTask: addTask,
                                    deleteTask: deleteTask,
                                  ),
                                ),
                              )
                            ];
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList(
      {Key key,
      this.index,
      this.content,
      this.dateTime,
      this.tasks,
      this.editTask,
      this.addTask,
      this.deleteTask})
      : super(key: key);
  final int index;
  final String content;
  final String dateTime;
  final List<Task> tasks;
  final Function editTask;
  final Function addTask;
  final Function deleteTask;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = <Task>[];

  @override
  void initState() {
    super.initState();
    tasks.addAll(widget.tasks);
  }

  @override
  Widget build(BuildContext context) {
    final lists = <Widget>[];
    tasks.forEach((element) {
      lists.add(Container(
        child: ChildView(
          key: ValueKey(element),
          todoIndex: widget.index,
          index: tasks.indexOf(element),
          content: element.content,
          dateTime: element.date,
          deleteItem: (int i, int j) {
            widget.deleteTask(i, j);
            setState(() {
              tasks.removeAt(j);
            });
          },
          editTodo: editTask,
        ),
      ));
    });
    lists.add(Container(
      child: AddChildView(
        index: widget.index,
        content: '添加新的Task项',
        dateTime: '',
        addTask: (int i) async {
          final task = await widget.addTask(i);
          tasks.add(task);
          setState(() {});
        },
      ),
    ));
    return Container(
      height: ((tasks.length + 1) * 40).toDouble(),
      child: ListView(
        children: lists,
      ),
    );
  }

  Future<Task> editTask(int i, int j) async {
    final task = await widget.editTask(i, j);
    if (task == null) return null;
    setState(() {
      tasks[j].content = task.content;
    });
    return task;
  }
}
