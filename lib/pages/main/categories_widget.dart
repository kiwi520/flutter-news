import 'package:flutter/material.dart';
import 'package:news_app/common/entity/entities.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';

Widget newsCategoriesWidget(
    {required List<CategoryResponseEntity> categories,
    required String selCategoryCode,
    Function(CategoryResponseEntity)? onTap}) {
  return categories == null
      ? Container()
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map<Widget>((item) {
              return Container(
                alignment: Alignment.center,
                height: duSetHeight(52),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  child: Text(
                    item.title.toString(),
                    style: TextStyle(
                      color: selCategoryCode == item.code
                          ? AppColors.secondaryElementText
                          : AppColors.primaryText,
                      fontSize: duSetFontSize(18),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => onTap!(item),
                ),
              );
            }).toList(),
          ),
        );
}
