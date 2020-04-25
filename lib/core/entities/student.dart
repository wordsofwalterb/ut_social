import 'dart:convert';

import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String fullName;
  final String avatarUrl;
  final String id;

  Student({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.fullName = '',
    this.avatarUrl = '',
    this.id = '',
  });

  Student copyWith({
    String firstName,
    String lastName,
    String email,
    String fullName,
    String avatarUrl,
    String id,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
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
      'email': email,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  static Student fromJson(String source) => fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      email,
      fullName,
      avatarUrl,
      id,
    ];
  }

  static Student fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Student(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      fullName: map['fullName'],
      avatarUrl: map['avatarUrl'],
      id: map['id'],
    );
  }
}
