import 'package:app_utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:my_news_app/common/asset_imageLoader_factory.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';

import 'widget/tag_widget.dart';

class NewsItem extends StatelessWidget {
  final ThemeData theme;
  final News news;
  final Function onTap;

  const NewsItem({required this.theme, required this.news, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing, vertical: AppDimen.spacingNormal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(news.title ?? "",
                    style: theme.textTheme.titleMedium, textAlign: TextAlign.left, maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: AppDimen.spacingSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    loadAssetImage(news.urlToImage, width: 100.w, height: 70.h),
                    SizedBox(width: AppDimen.spacingLarge),
                    Expanded(
                        child:
                            Text(news.description ?? "", style: theme.textTheme.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis)),
                  ],
                ),
                SizedBox(height: AppDimen.spacingSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Utils.formatDate(news.publishedAt), style: theme.textTheme.bodySmall),
                    QueryTagWidget(gueryTag: news.query),
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
