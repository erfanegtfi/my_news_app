// ignore_for_file: must_call_super

import 'package:app_widgets/base/my_scaffold.dart';
import 'package:app_widgets/utils_message.dart';
import 'package:app_widgets/widget_item_not_found.dart';
import 'package:data/remote/exception/network_connection_exception.dart';
import 'package:data/remote/exception/server_error.dart';
import 'package:design_system/resources/app_assets.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/di/locator.dart';
import 'package:app_widgets/error_widget.dart';
import 'package:my_news_app/features/news/presenter/news_content_screen.dart';
import 'package:my_news_app/navigation/navigation_service.dart';

import 'item_news_list.dart';
import 'providers/news_list_provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  NewsListScreenState createState() => NewsListScreenState();
}

class NewsListScreenState extends State<NewsListScreen> {
  late ThemeData theme;
  late GetNewsListCubit getNewsListCubit;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  ScrollController? controller;
  final int _scrollThreshold = 800;
  bool isLoading = false;

  NewsListScreenState();

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);

    getNewsListCubit = locator<GetNewsListCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNewsListCubit.getAllNewsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return MyScaffold(
        appBar: AppBar(title: Text(AppText.newsScreenTitle, style: theme.textTheme.titleLarge)),
        body: RefreshIndicator(key: _refreshIndicatorKey, onRefresh: _refresh, child: newsListView()));
  }

  Widget newsListView() {
    return BlocConsumer<GetNewsListCubit, GetNewsListViewState>(
      bloc: getNewsListCubit,
      builder: (context, state) {
        if (state.loading == true)
          return Center(child: CircularProgressIndicator());
        else if (state.allNews?.isNotEmpty == true) {
          isLoading = false;
          return ListView.separated(
              controller: controller,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) => NewsItem(
                    theme: theme,
                    news: state.allNews![index],
                    onTap: () {
                      locator<NavigationService>().push(NewsContentScreen(news: state.allNews![index]));
                    },
                    key: ValueKey(state.allNews?[index].title),
                  ),
              itemCount: state.allNews?.length ?? 0);
        } else if (state.allNews?.isEmpty == true)
          return ListView(children: [SizedBox(height: 200.h), const ItemNotFoundWidget(message: AppText.newsNotFound)]);
        else if (state.error != null) return getErrorWidget(state.error!);

        return SizedBox();
      },
      buildWhen: (previous, current) {
        if (current.error?.appException is NetworkConnectionException) return false;
        return true;
      },
      listener: (context, state) {
        if (state.error != null) showToast(state.error?.message);
      },
    );
  }

  Widget getErrorWidget(GeneralError error) {
    return ListView(children: [
      SizedBox(height: 200.h),
      MyErrorWidget(
          image: (error.appException is NetworkConnectionException) ? AppAssets.iconWifi : AppAssets.iconPaper, message: error.message),
    ]);
  }

  Future<void> _refresh() {
    getNewsListCubit.getAllNewsList(resetPage: true);
    return Future.delayed(Duration(milliseconds: 2));
  }

  /// handel scroll listener for pagination
  void _scrollListener() {
    if (controller != null) {
      final double maxScroll = controller!.position.maxScrollExtent;
      final double currentScroll = controller!.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        if (!isLoading) {
          isLoading = true;
          getNewsListCubit.getAllNewsList();
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_scrollListener);
    super.dispose();
  }
}
