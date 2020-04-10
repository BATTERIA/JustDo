import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/jcolors.dart';

typedef EditCallback = Function(int index);

class ChildView extends StatelessWidget {
  const ChildView(
      {Key key,
        this.index,
        this.content,
        this.dateTime,
        this.deleteItem,
        this.editTodo})
      : super(key: key);

  final int index;
  final String content;
  final String dateTime;
  final Function deleteItem;
  final EditCallback editTodo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('key$index'),
      child: buildCardView(content, dateTime),
      onDismissed: (_) => deleteItem(),
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
                    onTap: deleteItem,
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.delete_outline,
                        size: 17,
                        color: JColors.itemColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 150,
                    child: GestureDetector(
                      onTap: () => editTodo(index),
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
