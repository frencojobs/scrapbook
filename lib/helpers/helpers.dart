import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

String _ignoreSubMicro(String s) {
  if (s.length > 27) return s.substring(0, 26) + s[s.length - 1];
  return s;
}

String formatTimeFromJson(String time) {
  final current = DateTime.now();
  final happened = DateTime.parse(_ignoreSubMicro(time));
  final difference = current.difference(happened);
  return timeago.format(current.subtract(difference));
}

String formatText(String text) {
  final result = text.replaceAllMapped(
    RegExp(r'<([^|>]+)\|([^|<]+)>'),
    (match) {
      return '[${match.group(1)}](${match.group(2)})';
    },
  );

  final parser = EmojiParser();
  return parser.emojify(result);
}

Future<void> launchURL(BuildContext context, String url) async {
  try {
    await launch(
      url,
      option: CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
      ),
    );
  } catch (e) {
    print(e.toString());
  }
}
