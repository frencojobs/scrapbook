import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scrapbook/state/state.dart';
import 'package:scrapbook/theme/colors.dart';
import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/pages/home.page.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scrapbook',
        theme: ThemeData(
          primaryColor: ThemedColors.primary,
          fontFamily: ThemedFonts.primary().fontFamily,
          splashFactory: InkRipple.splashFactory,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: HomePage(),
      ),
    );
  }
}
