import 'package:timeago/timeago.dart' as timeago;

String formatTimeFromJson(String time) {
  final current = DateTime.now();
  final happened = DateTime.parse(time);
  final difference = current.difference(happened);
  return timeago.format(current.subtract(difference));
}

String formatText(String text) {
  return text;
}
