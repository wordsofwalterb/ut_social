import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
abstract class Student with _$Student {
  /// Creates an object representing public information about
  /// a student user.
  ///
  /// Although this information may be obscured to other users,
  /// it will be available if app is compromised hence public.
  ///
  /// [fullName] and [id] are required and must not be null
  const factory Student({
    @required String id,
    @required String fullName,
    @Default([]) List<String> channels,
    String bio,
    String firstName,
    String lastName,
    String coverPhotoUrl,
    String email,
    String avatarUrl,
    @Default(false) bool notificationsEnabled,
    int reportCount,
    @Default(false) bool isTester,
  }) = _Student;

  /// Converts a map of items with same variable name (key) and type for value
  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
