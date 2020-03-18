import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/room_dialog.dart';

typedef ConfirmedCallback = Function(String content);

class EditDialog {
  EditDialog({this.onConfirm});

  final ConfirmedCallback onConfirm;

  TextEditingController _controller = TextEditingController();

  void show(BuildContext context) {
    RoomDialog(
      content: (context) => _EditView(controller: _controller,),
      rightButtonBuilder: (_) =>
          DialogButtonData(text: '确认', onClick: () => onConfirm(_controller.text)),
    ).show(context);
  }
}

class _EditView extends StatelessWidget {
  const _EditView({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
