import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_system/resources/export_app_res.dart';
import 'package:my_news_app/features/news/presenter/news_list_screen.dart';
import 'package:my_news_app/di/locator.dart';
import 'package:my_news_app/navigation/navigation_service.dart';

class MyApp extends ConsumerStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => Consumer(
              builder: (context, ref, __) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: const Locale("fa", "IR"),
                  title: AppText.appName,
                  theme: lightTheme,
                  home: NewsListScreen(),
                  navigatorKey: locator<NavigationService>().navigatorKey,
                );
              },
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
