import 'package:json_annotation/json_annotation.dart';
import 'package:scrapbook/helpers/helpers.dart';

part 'models.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String username;
  final String avatar;
  final String css;
  final bool streakDisplay;
  final int streakCount;
  final String slack;
  final String github;
  final String website;

  User({
    this.id,
    this.username,
    this.avatar,
    this.css,
    this.streakDisplay,
    this.streakCount,
    this.slack,
    this.github,
    this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}

@JsonSerializable()
class Attachment {
  final String id;
  final String url;
  final String filename;
  final int size;
  final String type;

  Attachment({
    this.id,
    this.url,
    this.filename,
    this.size,
    this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return _$AttachmentFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$AttachmentToJson(this);
  }
}

@JsonSerializable()
class Post {
  final String id;
  final User user;

  @JsonKey(fromJson: formatTimeFromJson)
  final String postedAt;

  @JsonKey(fromJson: formatText)
  final String text;

  final List<Attachment> attachments;

  Post({
    this.id,
    this.user,
    this.postedAt,
    this.text,
    this.attachments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return _$PostFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$PostToJson(this);
  }
}
