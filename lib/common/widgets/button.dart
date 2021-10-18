import 'package:flutter/material.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/Radii.dart';
import 'package:news_app/common/values/values.dart';

/// 扁平圆角按钮
Widget btnElevatedButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color backgroundColor = AppColors.primaryElement,
  Color foregroundColor = AppColors.primaryElement,
  Color borderColor = AppColors.primaryElement,
  String title = "button",
  Color fontColor = AppColors.primaryElementText,
  double fontSize = 18,
  String fontName = "Montserrat",
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Container(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: ElevatedButton(
      onPressed: onPressed,
      // color: gbColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: Radii.k6pxRadius,
      // ),
      style: ButtonStyle(
        foregroundColor:
        MaterialStateProperty.all(foregroundColor),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        side: MaterialStateProperty.all(
            BorderSide(width: 1, color: borderColor)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: Radii.k6pxRadius,
          ),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontName,
          fontWeight: fontWeight,
          fontSize: duSetFontSize(fontSize),
          height: 1,
        ),
      ),
    ),
  );
}

/// 第三方按钮
Widget btnElevatedButtonBorderOnlyWidget({
  required VoidCallback onPressed,
  double width = 88,
  double height = 44,
  Color borderColor = AppColors.primaryElement,
  required String iconFileName,
}) {
  return Container(
    width: duSetWidth(width),
    height: duSetHeight(height),
    child: ElevatedButton(
      onPressed: onPressed,
      // shape: RoundedRectangleBorder(
      //   side: Borders.primaryBorder,
      //   borderRadius: Radii.k6pxRadius,
      // ),
      style: ButtonStyle(
        // foregroundColor:
        // MaterialStateProperty.all(AppColors.primaryBackground),
        backgroundColor: MaterialStateProperty.all(AppColors.primaryBackground),
        side: MaterialStateProperty.all(
            Borders.primaryBorder),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: Radii.k6pxRadius,
          ),
        ),
      ),
      child: Image.asset(
        "assets/images/icons-$iconFileName.png",
      ),
    ),
  );
}
