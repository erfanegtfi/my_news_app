// ignore_for_file: must_call_super

import 'package:app_utils/view_state.dart';
import 'package:app_widgets/base/base_screen.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/features/news/domain/entities/news_model.dart';

import 'news_list_provider.dart';

class NewsListScreen extends BaseScreen {
  NewsListScreen({super.key});

  @override
  NewsListScreenState createState() => NewsListScreenState();
}

class NewsListScreenState extends BaseScreenState<NewsListScreen> {
  late ThemeData theme;
  late NewsProviderNotifier newsListNotifier;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  NewsListScreenState();

  @override
  void initState() {
    super.initState();
    newsListNotifier = ref.read(newsProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsListNotifier.getAllNewsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return body(context, appBar: AppBar(title: Text(AppText.newsScreenTitle)));
  }

  @override
  Widget getScreenBody() {
    return RefreshIndicator(key: _refreshIndicatorKey, onRefresh: _refresh, child: newsListView());
  }

  Widget newsListView() {
    return Consumer(builder: (context, ref, __) {
      final reqult = ref.watch(newsProvider);
      return reqult.maybeWhen(
        loading: () => Center(child: CircularProgressIndicator()),
        success: (news) {
          if (news.isNotEmpty) {
            return ListView.builder(itemBuilder: (context, index) => Text(news[index].title ?? ""), itemCount: news.length);
          } else {
            return ListView(children: [SizedBox(height: 100.h), const Text("--------")]);
          }
        },
        serverError: (error) => const SizedBox(),
        orElse: () => const SizedBox(),
      );
    });
  }

  Future<void> _refresh() {
    ref.read(newsProvider.notifier).getAllNewsList(resetPage: true);
    return Future.delayed(Duration(milliseconds: 2));
  }

  @override
  setupProviderListeners() {
    setupNewsProviderListener();
  }

  setupNewsProviderListener() {
    ref.listen<ViewState<List<News>>>(newsProvider, (previous, next) {
      next.maybeWhen(orElse: () {}, serverError: (error) {});
    });
  }
}
