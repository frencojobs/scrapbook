import 'package:flutter/material.dart';
import 'package:typeweight/typeweight.dart';

import 'package:scrapbook/theme/fonts.dart';
import 'package:scrapbook/components/action_button.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
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
      body: Text('Profile'),
    );
  }
}
