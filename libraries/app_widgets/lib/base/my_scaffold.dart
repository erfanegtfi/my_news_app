import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;
  final GlobalKey? scaffoldKey;
  final Widget body;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;

  const MyScaffold({
    required this.body,
    this.scaffoldKey,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      body: body,
    );
  }
}
