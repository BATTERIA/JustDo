import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/jcolors.dart';

import 'small_card_view.dart';

typedef EditCallback = Function(int index);

class CardView extends StatelessWidget {
  const CardView(
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
                              const PopupMenuItem(
                                child: ChildView(
                                  content: '123',
                                  dateTime: '13',
                                ),
                              ),
                            ];
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: [
//                Container(
//                  child: GestureDetector(
//                    onTap: () => editTodo(index),
//                    child: Text(
//                      value,
//                      style: TextStyle(
//                        color: JColors.textColor,
//                      ),
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                    ),
//                  ),
//                ),
//              ],
//            ),
          ],
        ),
      ),
    );
  }
}
