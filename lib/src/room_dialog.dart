import 'dart:math';

import 'package:flutter/material.dart';

/// blink 定制弹窗
///
/// Typical usage:
///
/// ```dart
///
/// RoomDialog(
///  content: (_) => Image.asset(ImageNames.closeLive, height: 200),
///  leftButtonBuilder: (context) => DialogButtonData(text: '断开直播'),
///  rightButtonBuilder: (context) => DialogButtonData(text: '继续直播'),
/// ).show(context);
///
///```
class RoomDialog extends StatelessWidget {
  const RoomDialog({
    @required this.content,
    this.leftButtonBuilder = _defaultLeftButtonBuilder,
    this.rightButtonBuilder = _defaultRightButtonBuilder,
    this.primaryColor,
    this.portrait = true,
  }) : assert(content != null);

  final Color primaryColor;

  /// 弹窗内容
  final WidgetBuilder content;

  /// 左边button的text、点击事件
  final ButtonBuilder leftButtonBuilder;

  /// 右边button的text、点击事件
  final ButtonBuilder rightButtonBuilder;

  final bool portrait;

  @override
  Widget build(BuildContext context) {
    var accentColor = Color(0xFFFB7299);
    if (primaryColor == null) accentColor = Theme.of(context).accentColor;
    final buttons = <Widget>[];
    if (leftButtonBuilder != null) {
      buttons.add(
          _bottomButton(context: context, buttonBuilder: leftButtonBuilder));
      buttons.add(_divider());
    }
    if (rightButtonBuilder != null) {
      buttons.add(
          _bottomButton(context: context, buttonBuilder: rightButtonBuilder));
      buttons.add(_divider());
    }
    buttons.removeLast();

    const radius = 4.0;

    final _dialogContent = portrait
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: content(context),
          )
        : ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 220),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: content(context),
              ),
            ),
          );

    return WillPopScope(
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _dialogContent,
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buttons,
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  static double defaultContentHeight(BuildContext context) {
    const standardScreenWidth = 375.0;
    const standardImageWidth = 200.0;
    final width = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return width >= standardScreenWidth
        ? standardImageWidth
        : standardImageWidth * width / standardScreenWidth - 22.0;
  }

  Widget _bottomButton({
    BuildContext context,
    ButtonBuilder buttonBuilder,
  }) {
    final buttonData = buttonBuilder(context);
    return Expanded(
      child: FlatButton(
        splashColor: Colors.transparent,
        onPressed: () {
          if (buttonData.onClick != null) {
            buttonData.onClick();
          } else {
            Navigator.pop(context);
          }
        },
        child: Text(
          buttonData.text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(color: Colors.white, height: double.infinity, width: 1),
    );
  }

  Future show(BuildContext context, {bool barrierDismissible = true}) async {
    await showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) => this);
  }
}

DialogButtonData _defaultLeftButtonBuilder(BuildContext context) =>
    const DialogButtonData(text: '取消');

DialogButtonData _defaultRightButtonBuilder(BuildContext context) =>
    const DialogButtonData(text: '确认');

typedef ButtonBuilder = DialogButtonData Function(BuildContext context);

class DialogButtonData {
  const DialogButtonData({this.text, this.onClick});

  final String text;

  final VoidCallback onClick;
}
