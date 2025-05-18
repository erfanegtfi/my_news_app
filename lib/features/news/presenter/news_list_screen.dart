// ignore_for_file: must_call_super

import 'package:app_utils/view_state.dart';
import 'package:app_widgets/base/base_screen.dart';
import 'package:app_widgets/widget_item_not_found.dart';
import 'package:data/remote/exception/network_connection_exception.dart';
import 'package:data/remote/exception/server_error.dart';
import 'package:design_system/resources/app_assets.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/data/di/locator.dart';
import 'package:my_news_app/features/news/domain/entities/news.dart';
import 'package:app_widgets/utils_message.dart';
import 'package:app_widgets/error_widget.dart';
import 'package:my_news_app/features/news/presenter/news_content_screen.dart';
import 'package:my_news_app/navigation/navigation_service.dart';

import 'item_news_list.dart';
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
    newsListNotifier.errorPublisher.listen((error) {
      showToast(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return body(context, appBar: AppBar(title: Text(AppText.newsScreenTitle, style: theme.textTheme.titleLarge)));
  }

  @override
  Widget getScreenBody() {
    return RefreshIndicator(key: _refreshIndicatorKey, onRefresh: _refresh, child: newsListView());
  }

  Widget newsListView() {
    return Consumer(builder: (context, ref, __) {
      final reqult = ref.watch(newsProvider);
      return reqult.when(
        init: () => SizedBox(),
        loading: () => Center(child: CircularProgressIndicator()),
        success: (news) {
          if (news.isNotEmpty) {
            return ListView.builder(
                itemBuilder: (context, index) => NewsItem(
                      theme: theme,
                      news: news[index],
                      onTap: () {
                        locator<NavigationService>().push(NewsContentScreen(news: news[index]));
                      },
                      key: ValueKey(news[index].title),
                    ),
                itemCount: news.length);
          } else {
            return ListView(children: [SizedBox(height: 200.h), const ItemNotFoundWidget(message: AppText.newsNotFound)]);
          }
        },
        serverError: (error) => getErrorWidget(error),
      );
    });
  }

  Widget getErrorWidget(GeneralError error) {
    return ListView(children: [
      SizedBox(height: 200.h),
      MyErrorWidget(
          image: (error.appException is NetworkConnectionException) ? AppAssets.iconWifi : AppAssets.iconPaper, message: error.message),
    ]);
  }

  Future<void> _refresh() {
    newsListNotifier.getAllNewsList(resetPage: true);
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
