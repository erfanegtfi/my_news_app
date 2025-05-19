// ignore_for_file: must_call_super

import 'package:app_utils/utils.dart';
import 'package:app_widgets/base/base_screen.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_news_app/common/asset_imageLoader_factory.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';

import 'widget/tag_widget.dart';

class NewsContentScreen extends BaseScreen {
  final News news;
  NewsContentScreen({required this.news, super.key});

  @override
  NewsContentScreenState createState() => NewsContentScreenState();
}

class NewsContentScreenState extends BaseScreenState<NewsContentScreen> {
  late ThemeData theme;

  NewsContentScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return body(context, appBar: AppBar(title: Text(widget.news.title ?? "", style: theme.textTheme.titleLarge, maxLines: 1)));
  }

  @override
  Widget getScreenBody() {
    return ListView(
      children: [
        AspectRatio(aspectRatio: 1.9, child: loadAssetImage(widget.news.urlToImage, height: 500, width: 800)),
        SizedBox(height: AppDimen.spacingLarge),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.news.title ?? "", style: theme.textTheme.titleLarge),
              SizedBox(height: AppDimen.spacingLarge),
              QueryTagWidget(gueryTag: widget.news.query),
              SizedBox(height: AppDimen.spacingNormal),
              Row(
                children: [
                  Icon(Icons.av_timer),
                  Text(Utils.formatDate(widget.news.publishedAt), style: theme.textTheme.bodySmall),
                  Spacer(),
                  Text("${AppText.newsContentScreenBy}: ${widget.news.author ?? ""}", style: theme.textTheme.bodySmall),
                ],
              ),
              SizedBox(height: AppDimen.spacingLarge),
              Text(widget.news.content ?? "", style: theme.textTheme.bodyMedium),
              SizedBox(height: AppDimen.spacingNormal),
              Divider(),
              SizedBox(height: AppDimen.spacingNormal),
              Text("${AppText.newsContentScreenSource}: ${widget.news.source?.name ?? ""}", style: theme.textTheme.bodySmall),
            ],
          ),
        )
      ],
    );
  }

  @override
  setupProviderListeners() {}
}
