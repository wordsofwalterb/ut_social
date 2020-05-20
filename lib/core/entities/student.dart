import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:ut_social/core/entities/identity.dart';

@immutable
abstract class StudentSnippet extends Equatable implements Identity {
  String get fullName;
  String get avatarUrl;
  const StudentSnippet();
}

class StudentChatSnippet extends StudentSnippet with EquatableMixin {
  @override
  final String fullName;
  @override
  final String avatarUrl;
  @override
  final String id;

  StudentChatSnippet({
    this.fullName,
    this.avatarUrl,
    this.id,
  });

  StudentChatSnippet copyWith({
    String fullName,
    String avatarUrl,
    String id,
  }) {
    return StudentChatSnippet(
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'id': id,
    };
  }

  factory StudentChatSnippet.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StudentChatSnippet(
      fullName: map['fullName'] as String ?? '',
      avatarUrl: map['avatarUrl'] as String ?? '',
      id: map['id'] as String ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentChatSnippet.fromJson(String source) =>
      StudentChatSnippet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [fullName, avatarUrl, id];

  @override
  bool get stringify => true;
}

class Student extends StudentSnippet {
  final String firstName;
  final String lastName;
  final String bio;
  final String coverPhotoUrl;
  final String email;
  @override
  final String fullName;
  @override
  final String avatarUrl;
  @override
  final String id;

  const Student({
    this.firstName,
    this.lastName,
    this.bio,
    this.coverPhotoUrl,
    this.email,
    @required this.fullName,
    this.avatarUrl,
    @required this.id,
  })  : assert(fullName != null),
        assert(id != null);

  Student copyWith({
    String firstName,
    String lastName,
    String bio,
    String coverPhotoUrl,
    String email,
    String fullName,
    String avatarUrl,
    String id,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'bio': bio,
      'coverPhotoUrl': coverPhotoUrl,
      'email': email,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'id': id,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Student(
      firstName: map['firstName'] as String ?? '',
      lastName: map['lastName'] as String ?? '',
      email: map['email'] as String ?? '',
      fullName: map['fullName'] as String ?? '',
      avatarUrl: map['avatarUrl'] as String ?? '',
      id: map['id'] as String ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      bio,
      coverPhotoUrl,
      email,
      fullName,
      avatarUrl,
      id,
    ];
  }

  @override
  bool get stringify => true;
}
