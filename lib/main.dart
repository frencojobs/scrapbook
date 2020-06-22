import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrapbook/theme/theme.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:scrapbook/state/state.dart';
import 'package:scrapbook/theme/colors.dart';
import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/pages/settings.page.dart';
import 'package:scrapbook/pages/home/home.page.dart';

void main() {
  runApp(Mainframe());
}

class Mainframe extends StatefulWidget {
  @override
  _MainframeState createState() => _MainframeState();
}

class _MainframeState extends State<Mainframe> {
  final ScrapbookStore _store = ScrapbookStore();

  @override
  void initState() {
    super.initState();

    _store.loadPosts();
    _store.loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _store,
      child: ThemeProvider(
        themes: [
          AppTheme(
            id: 'light',
            description: 'App default light theme.',
            data: Themed.light,
          ),
          AppTheme(
            id: 'dark',
            description: 'App default dark theme.',
            data: Themed.dark,
          ),
        ],
        defaultThemeId: 'light',
        child: ThemeConsumer(
          child: Builder(builder: (themeContext) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Scrapbook',
              theme: ThemeProvider.themeOf(themeContext).data,
              routes: {
                '/settings': (_) => SettingsPage(),
              },
              home: HomePage(),
            );
          }),
        ),
      ),
    );
  }
}
