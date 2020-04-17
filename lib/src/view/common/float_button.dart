import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/constant/jcolors.dart';

import 'drag_view.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({Key key, this.position, this.onTap}) : super(key: key);
  final Offset position;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Dragging(
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: JColors.addItemColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 5),
              blurRadius: 5.0,
            )
          ],
        ),
        width: 40,
        height: 40,
        child: Icon(
          Icons.control_point,
          color: Color(0x66000000),
        ),
      ),
    );
  }
}
