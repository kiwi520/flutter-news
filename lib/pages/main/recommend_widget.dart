import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/entity/entities.dart';
import 'package:news_app/common/router/router.gr.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/image.dart';
import 'package:news_app/common/widgets/textClick.dart';
import 'package:news_app/common/widgets/widgets.dart';
import 'package:news_app/pages/details/details_page.dart';

// 推荐阅读
Widget recommendWidget(context,Items item) {


  return Container(
    margin: EdgeInsets.all(duSetWidth(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// 图片
        InkWell(
          child: imageCached(
            item.thumbnail!,
            width: duSetWidth(335),
            height: duSetHeight(290),
          ),
          onTap: () {
            /// 跳转到详情页面
            AutoRouter.of(context).push(Details(item:item));
            // context.router.pushNamed('/application-page');
          },
        ),

        // 作者
        Container(
          margin: EdgeInsets.only(top: duSetHeight(14)),
          child: Text(
            item.author!,
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.normal,
              color: AppColors.thirdElementText,
              fontSize: duSetFontSize(14),
            ),
          ),
        ),
        // 标题
        Container(
          margin: EdgeInsets.only(top: duSetHeight(10)),
          child: textClickWidget(
            textStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
              fontSize: duSetFontSize(24),
              height: 1,
            ), text: item.title!,
            textClick: () {
              AutoRouter.of(context).push(Details(item:item));
            },
          ),
        ),
        // 一行 3 列
        Container(
          margin: EdgeInsets.only(top: duSetHeight(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 分类
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 120,
                ),
                child: Text(
                  item.category!,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.normal,
                    color: AppColors.secondaryElementText,
                    fontSize: duSetFontSize(14),
                    height: 1,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
              ),
              // 添加时间
              Container(
                width: duSetWidth(15),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 120,
                ),
                child: Text(
                  '• ${duTimeLineFormat(DateTime.parse(item.addtime!))}',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.normal,
                    color: AppColors.thirdElementText,
                    fontSize: duSetFontSize(14),
                    height: 1,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                ),
              ),
              // 更多
              Spacer(),
              InkWell(
                child: Icon(
                  Icons.more_horiz,
                  color: AppColors.primaryText,
                  size: 24,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
