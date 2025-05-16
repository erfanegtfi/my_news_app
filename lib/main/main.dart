import 'dart:async';

import 'package:data/remote/configs/dio_configuration.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/app/app.dart';
import 'package:my_news_app/data/di/database_locator.dart';
import 'package:my_news_app/data/di/network_locator.dart';
import 'package:my_news_app/main/di/presenter_locator.dart';

import 'di/locator.dart';

appStarter() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    setupNetworkLocator();
    setupDatabaseLocator();
    setupAppPresenterLocator();

    await locator.allReady();
    DioConfig().init();

    runApp(
      ProviderScope(child: MyApp(), observers: []),
    );
  }, (exception, stackTrace) async {
    debugPrint(exception.toString());
  });
}
