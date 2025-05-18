import 'package:design_system/resources/app_assets.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:flutter/material.dart';

class ItemNotFoundWidget extends StatelessWidget {
  final String? image;
  final String? message;
  const ItemNotFoundWidget({super.key, this.image, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppDimen.verticalSpacing),
          Image.asset(image ?? AppAssets.iconPaper, height: 40, width: 40, package: "design_system"),
          SizedBox(height: AppDimen.spacingNormal),
          Text(message ?? AppText.itemNotFound, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: AppDimen.verticalSpacing),
        ],
      ),
    );
  }
}
