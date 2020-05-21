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
  final String id;

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
    this.firstName,
    this.lastName,
    this.bio,
    this.coverPhotoUrl,
    this.email,
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
    assert(map != null);
    assert(map['id'] != null);
    assert(map['fullName'] != null);

    return Student(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      avatarUrl: map['avatarUrl'] as String,
      id: map['id'] as String,
      coverPhotoUrl: map['coverPhotoUrl'].toString(),
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
}
