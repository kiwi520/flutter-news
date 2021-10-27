import 'package:flutter/material.dart';

/// 文本点击事件
Widget textClickWidget({
  required String text,
  TextStyle? textStyle,
  EdgeInsets? padding,
  Alignment? alignment,
  TextOverflow? overflow,
  int? maxLine,
  required GestureTapCallback textClick,
}) {
  return text == null
      ? Container()
      : Container(
          alignment: alignment,
          padding: padding,
          child: GestureDetector(
            child: Text(
              text,
              overflow: overflow,
              style: textStyle,
              maxLines: maxLine,
            ),
            onTap: textClick,
          ),
        );
}
