import 'dart:convert';

import 'package:equatable/equatable.dart';

class FFNotification extends Equatable {
  final String title;
  final String body;
  final String imageUrl;
  final DateTime timestamp;

  const FFNotification({
    this.title,
    this.body,
    this.imageUrl,
    this.timestamp,
  });

  FFNotification copyWith({
    String title,
    String body,
    String imageUrl,
    DateTime timestamp,
  }) {
    return FFNotification(
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }

  factory FFNotification.fromMap(Map<String, dynamic> map, DateTime timestamp) {
    if (map == null) return null;

    return FFNotification(
      title: map['title'] as String,
      body: map['body'] as String,
      imageUrl: map['imageUrl'] as String,
      timestamp: timestamp,
    );
  }

  factory FFNotification.fromiOS(Map<String, dynamic> map, DateTime timestamp) {
    if (map == null) return null;

    return FFNotification(
      title: map['aps']['alert']['title'] as String,
      body: map['aps']['alert']['body'] as String,
      imageUrl: map['imageUrl'] as String,
      timestamp: timestamp,
    );
  }

  factory FFNotification.fromAndroid(
      Map<String, dynamic> map, DateTime timestamp) {
    if (map == null) return null;

    return FFNotification(
      title: map['notification']['title'] as String,
      body: map['notification']['body'] as String,
      imageUrl: map['data']['imageUrl'] as String,
      timestamp: timestamp,
    );
  }

  @override
  List<Object> get props => [title, body, imageUrl, timestamp];

  @override
  bool get stringify => true;
}
