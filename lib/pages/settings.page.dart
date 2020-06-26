import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:typeweight/typeweight.dart';

import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/components/action_button.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
          style: ThemedFonts.primary(
            fontWeight: TypeWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: ActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: NavigationToolbar.kMiddleSpacing,
                vertical: NavigationToolbar.kMiddleSpacing / 2,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: theme.dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: NavigationToolbar.kMiddleSpacing + 24,
                  ),
                  Text(
                    'Dark Mode',
                    style: ThemedFonts.primary(
                      fontSize: theme.textTheme.subtitle1.fontSize,
                      fontWeight: TypeWeight.medium,
                    ),
                  ),
                  Flexible(child: Container()),
                  Switch(
                    value: ThemeProvider.themeOf(context).id == 'dark',
                    onChanged: (v) {
                      if (ThemeProvider.themeOf(context).id == 'dark') {
                        ThemeProvider.controllerOf(context).setTheme('light');
                      } else {
                        ThemeProvider.controllerOf(context).setTheme('dark');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
