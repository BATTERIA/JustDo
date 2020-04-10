import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/jcolors.dart';

class AddCard extends StatelessWidget {
  const AddCard(
      {Key key,
        this.index,
        this.content,
        this.dateTime,
        this.deleteItem})
      : super(key: key);

  final int index;
  final String content;
  final String dateTime;
  final Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return buildCardView(content, dateTime, context);
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
                    Container(
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Text(
                        key,
                        style: TextStyle(color: JColors.textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 30,
                      height: 30,
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
