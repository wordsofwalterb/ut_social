import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Student extends Equatable {
  final String firstName, lastName, email, fullName, avatarUrl, id;

  Student(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.id,
      @required this.fullName,
      @required this.avatarUrl})
      : assert(firstName != null),
        assert(lastName != null),
        assert(email != null),
        assert(id != null),
        assert(fullName != null);

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      lastName: map['lastName'],
      firstName: map['firstName'],
      email: map['email'],
      avatarUrl: map['avatarUrl'] ?? '',
      fullName: map['firstName'].toString() + ' ' + map['lastName'].toString(),
    );
  }

  @override
  List<Object> get props => [firstName, lastName, email, fullName, avatarUrl];
}