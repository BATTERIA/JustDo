import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/jcolors.dart';

class ChildView extends StatefulWidget {
  const ChildView({
    Key key,
    this.todoIndex,
    this.index,
    this.content = '',
    this.dateTime = '',
    this.deleteItem,
    this.editTodo,
  }) : super(key: key);
  final todoIndex;
  final int index;
  final String content;
  final String dateTime;
  final Function deleteItem;
  final Function editTodo;

  @override
  _ChildViewState createState() => _ChildViewState();
}

class _ChildViewState extends State<ChildView> {
  String content;

  @override
  void initState() {
    super.initState();
    content = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('key${widget.index}'),
      child: buildCardView(content, widget.dateTime),
      onDismissed: (_) => widget.deleteItem(widget.todoIndex, widget.index),
    );
  }

  Widget buildCardView(String key, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 40,
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
                    onTap: () =>
                        widget.deleteItem(widget.todoIndex, widget.index),
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.delete,
                        size: 17,
                        color: JColors.itemColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 150,
                    child: GestureDetector(
                      onTap: () async {
                        final task = await widget.editTodo(
                            widget.todoIndex, widget.index);
                        setState(() {
                          content = task.content;
                        });
                      },
                      child: Text(
                        key,
                        style: TextStyle(color: JColors.itemColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddChildView extends StatefulWidget {
  const AddChildView({
    Key key,
    this.index,
    this.content,
    this.dateTime,
    this.addTask,
  }) : super(key: key);

  final int index;
  final String content;
  final String dateTime;
  final Function addTask;

  @override
  _AddChildViewState createState() => _AddChildViewState();
}

class _AddChildViewState extends State<AddChildView> {
  @override
  Widget build(BuildContext context) {
    return buildCardView(widget.content, widget.dateTime);
  }

  Widget buildCardView(String key, String value) {
    return GestureDetector(
      onTap: () {
        widget.addTask(widget.index);
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 150,
                      child: Text(
                        key,
                        style: TextStyle(color: JColors.itemColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
