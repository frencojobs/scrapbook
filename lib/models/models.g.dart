// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    username: json['username'] as String,
    avatar: json['avatar'] as String,
    css: json['css'] as String,
    streakDisplay: json['streakDisplay'] as bool,
    streakCount: json['streakCount'] as int,
    slack: json['slack'] as String,
    github: json['github'] as String,
    website: json['website'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'css': instance.css,
      'streakDisplay': instance.streakDisplay,
      'streakCount': instance.streakCount,
      'slack': instance.slack,
      'github': instance.github,
      'website': instance.website,
    };

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return Attachment(
    id: json['id'] as String,
    url: json['url'] as String,
    filename: json['filename'] as String,
    size: json['size'] as int,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'filename': instance.filename,
      'size': instance.size,
      'type': instance.type,
    };

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    postedAt: formatTimeFromJson(json['postedAt'] as String),
    text: formatText(json['text'] as String),
    attachments: (json['attachments'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'postedAt': instance.postedAt,
      'text': instance.text,
      'attachments': instance.attachments,
    };
