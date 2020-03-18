import 'package:flutter/material.dart';

class Dragging extends StatefulWidget {
  const Dragging({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  DraggingState createState() => DraggingState();
}

class DraggingState extends State<Dragging> {
  Offset position;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (position == null) {
      position = Offset(size.width - 30, size.height - 30);
    }

    return Positioned(
      right: size.width - position.dx,
      bottom: size.height - position.dy,
      child: Draggable(
          feedback: Container(
            child: widget.child,
          ),
          child: Container(
            child: widget.child,
          ),
          childWhenDragging: Container(),
          onDragEnd: (details) {
            setState(() {
              final offset = details.offset;
              var dx = (offset.dx > 0) ? offset.dx : 5.0;
              dx = (dx > size.width) ? size.width - 55 : dx;
              var dy = (offset.dy > 0) ? offset.dy : 5.0;
              dy = (dy > size.height) ? size.height - 55 : dy;
              position = Offset(dx + 40, dy + 40);
            });
          }),
    );
  }
}
