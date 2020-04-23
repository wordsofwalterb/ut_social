import 'dart:convert';

import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String fullName;
  final String avatarUrl;
  final String id;
  final List<String> likedPosts;
  final List<String> likedComments;

  Student({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.fullName = '',
    this.avatarUrl = '',
    this.id = '',
    this.likedPosts = const [],
    this.likedComments = const [],
  });

  Student copyWith({
    String firstName,
    String lastName,
    String email,
    String fullName,
    String avatarUrl,
    String id,
    List<String> likedPosts,
    List<String> likedComments,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      id: id ?? this.id,
      likedPosts: likedPosts ?? this.likedPosts,
      likedComments: likedComments ?? this.likedComments,
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
      'likedPosts': List<dynamic>.from(likedPosts.map((x) => x)),
      'likedComments': List<dynamic>.from(likedComments.map((x) => x)),
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
      likedPosts,
      likedComments,
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
      likedPosts: List<String>.from(map['likedPosts']),
      likedComments: List<String>.from(map['likedComments']),
    );
  }
}
