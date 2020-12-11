// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Student _$_$_StudentFromJson(Map<String, dynamic> json) {
  return _$_Student(
    id: json['id'] as String,
    fullName: json['fullName'] as String,
    channels:
        (json['channels'] as List)?.map((e) => e as String)?.toList() ?? [],
    bio: json['bio'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    coverPhotoUrl: json['coverPhotoUrl'] as String,
    email: json['email'] as String,
    avatarUrl: json['avatarUrl'] as String,
    notificationsEnabled: json['notificationsEnabled'] as bool ?? false,
    reportCount: json['reportCount'] as int,
    isTester: json['isTester'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_StudentToJson(_$_Student instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'channels': instance.channels,
      'bio': instance.bio,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'coverPhotoUrl': instance.coverPhotoUrl,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'notificationsEnabled': instance.notificationsEnabled,
      'reportCount': instance.reportCount,
      'isTester': instance.isTester,
    };
