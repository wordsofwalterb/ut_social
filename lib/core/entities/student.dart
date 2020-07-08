import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// The student class represents the publically available
/// information about a student user.
class Student extends Equatable {
  final String firstName;
  final String lastName;
  final String bio;
  final String coverPhotoUrl;
  final String email;
  final String fullName;
  final String avatarUrl;
  final bool notificationsEnabled;
  final String id;
  final List<String> channels;
  final int reportCount;
  final bool isTester;

  /// Creates an object representing public information about
  /// a student user.
  ///
  /// Although this information may be obscured to other users,
  /// it will be available if app is compromised hence public.
  ///
  /// [fullName] and [id] are required and must not be null
  const Student({
    @required this.id,
    @required this.fullName,
    this.channels,
    this.notificationsEnabled,
    this.reportCount,
    this.firstName,
    this.lastName,
    this.bio,
    this.coverPhotoUrl,
    this.email,
    this.isTester,
    this.avatarUrl,
  })  : assert(fullName != null),
        assert(id != null);

  Student copyWith({
    String firstName,
    String lastName,
    String bio,
    String coverPhotoUrl,
    String email,
    String fullName,
    bool notificationsEnabled,
    String avatarUrl,
    String id,
    int reportCount,
    bool isTester,
    List<String> channels,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      reportCount: reportCount ?? this.reportCount,
      channels: channels ?? this.channels,
      bio: bio ?? this.bio,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      isTester: isTester ?? this.isTester,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'reportCount': reportCount,
      'channels': channels,
      'bio': bio,
      'coverPhotoUrl': coverPhotoUrl,
      'email': email,
      'notificationsEnabled': notificationsEnabled,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'test': isTester,
      'id': id,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    assert(map != null);
    assert(map['id'] != null);
    assert(map['fullName'] != null);

    return Student(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      notificationsEnabled: map['notificationsEnabled'] as bool ?? false,
      fullName: map['fullName'] as String,
      avatarUrl: map['avatarUrl'] as String,
      channels: List<String>.from(map['channels'] as List ?? []),
      reportCount: map['reportCount'] as int,
      id: map['id'] as String,
      isTester: (map['test'] as bool) ?? false,
      coverPhotoUrl: map['coverPhotoUrl'] as String,
      bio: map['bio'] as String,
    );
  }

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      reportCount,
      channels,
      bio,
      coverPhotoUrl,
      email,
      fullName,
      avatarUrl,
      isTester,
      id,
      notificationsEnabled,
    ];
  }
}
