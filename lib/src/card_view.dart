import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/jcolors.dart';

class CardView extends StatelessWidget {
  const CardView({Key key, this.content, this.dateTime, this.deleteItem}) : super(key: key);

  final String content;
  final String dateTime;
  final Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return buildCardView(content, dateTime);
  }

  Widget buildCardView(String key, String value) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
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
//                        color: JColors.deleteItemColor,
                        child: Icon(Icons.delete_outline),
                      ),
                    ),
                    SizedBox(
                      width: 20
                    ),
                    Text(key, style: TextStyle(color: JColors.textColor),),
                  ],
                ),
                SizedBox(
                  width: 20
                ),
                Text(value, style: TextStyle(color: JColors.textColor),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
