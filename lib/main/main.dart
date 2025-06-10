import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news_app/app/app.dart';

import '../di/locator.dart';

appStarter() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
    await locator.allReady();

    runApp(
      ProviderScope(child: MyApp(), observers: []),
    );
  }, (exception, stackTrace) async {
    debugPrint(exception.toString());
  });
}
