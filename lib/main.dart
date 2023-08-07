import 'package:flutter/material.dart';
import 'package:qualrole/router.dart';

import 'common/theme.dart';
import 'util/configure_non_web.dart'
if (dart.library.html) 'util/configure_web.dart';
import 'widgets/widgets.dart';

void main() {
  configureApp();
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeModeScope(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'Qual é o rolê?',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          routerConfig: router,
        );
      },
    );
  }
}