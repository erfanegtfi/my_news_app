import 'package:app_widgets/base/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseScreen extends ConsumerStatefulWidget {
  BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseScreenState<T extends BaseScreen> extends ConsumerState<T> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ThemeData theme;
  @override
  void initState() {
    super.initState();
  }

  Widget body(
    BuildContext context, {
    PreferredSizeWidget? appBar,
    Widget? bottomNavigationBar,
    Color? background,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
  }) {
    setupProviderListeners();
    theme = Theme.of(context);
    return MyScaffold(
      backgroundColor: background,
      appBar: appBar,
      scaffoldKey: _scaffoldKey,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: getScreenBody(),
      ),
    );
  }

  setupProviderListeners();
  getScreenBody();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
