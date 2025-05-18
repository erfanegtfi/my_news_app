import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:app_widgets/widget_my_background.dart';
import 'package:my_news_app/features/news/domain/entities/enums/news_query.dart';

class QueryTagWidget extends StatelessWidget {
  final NewsQuery? gueryTag;

  const QueryTagWidget({super.key, required this.gueryTag});

  @override
  Widget build(BuildContext context) {
    return MyBackground(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.spacingMedium, vertical: AppDimen.spacingTiny),
      colorBack: Colors.grey.shade300,
      child: Text(gueryTag?.apiQuery ?? "", style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
