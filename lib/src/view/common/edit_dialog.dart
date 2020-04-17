import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_do/src/view/common/room_dialog.dart';

typedef ConfirmedCallback = Function(String content);

class EditDialog {
  EditDialog({this.onConfirm, this.defaultText = ''});

  final ConfirmedCallback onConfirm;

  final String defaultText;

  TextEditingController _controller = TextEditingController();

  Future show(BuildContext context) async {
    await RoomDialog(
      content: (context) => _EditView(
        controller: _controller,
        onConfirm: onConfirm,
        defaultText: defaultText,
      ),
      rightButtonBuilder: (_) => DialogButtonData(
          text: '确认', onClick: () => onConfirm(_controller.text)),
    ).show(context);
  }
}

class _EditView extends StatefulWidget {
  const _EditView({Key key, this.controller, this.onConfirm, this.defaultText})
      : super(key: key);

  final TextEditingController controller;

  final ConfirmedCallback onConfirm;

  final String defaultText;

  @override
  __EditViewState createState() => __EditViewState();
}

class __EditViewState extends State<_EditView> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.defaultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: widget.controller,
            onSubmitted: (content) => widget.onConfirm(content),
          ),
        ],
      ),
    );
  }
}
