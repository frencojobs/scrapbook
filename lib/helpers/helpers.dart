import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_emoji/flutter_emoji.dart';

String formatTimeFromJson(String time) {
  final current = DateTime.now();
  final happened = DateTime.parse(time);
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
