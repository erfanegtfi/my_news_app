// ignore_for_file: must_call_super

import 'package:app_widgets/base/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsListScreen extends BaseScreen {
  NewsListScreen({super.key});

  @override
  NewsListScreenState createState() => NewsListScreenState();
}

class NewsListScreenState extends BaseScreenState<NewsListScreen> {
  late ThemeData theme;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  NewsListScreenState();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return body(context);
  }

  @override
  Widget getScreenBody() {
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  setupProviderListeners() {}
}
