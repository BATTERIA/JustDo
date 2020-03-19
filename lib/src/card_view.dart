import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/jcolors.dart';

typedef EditCallback = Function(int index);

class CardView extends StatelessWidget {
  const CardView(
      {Key key, this.index, this.content, this.dateTime, this.deleteItem, this.editTodo})
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
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 60,
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: deleteItem,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.delete_outline),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => editTodo(index),
                  child: Text(
                    key,
                    style: TextStyle(color: JColors.textColor),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Text(
              value,
              style: TextStyle(color: JColors.textColor),
            ),
          ],
        ),
      ),
    );
  }
}
