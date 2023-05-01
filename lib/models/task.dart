// ignore_for_file: public_member_api_docs, sort_constructors_first
import "dart:convert";

import "package:equatable/equatable.dart";

class Task extends Equatable {
  final String title;
  final String id;
  final String description;
  bool? isDone;
  bool? isDeleted;
  Task({
    required this.description,
    required this.id,
    required this.title,
    this.isDone = false,
    this.isDeleted = false,
  });

  @override
  List<Object?> get props => [
        title,
        isDeleted,
        isDone,
        id,
        description,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "description": description,
      "title": title,
      "id": id,
      "isDone": isDone,
      "isDeleted": isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      description: map["description"] as String,
      title: map["title"] as String,
      id: map["id"] as String,
      isDone: map["isDone"] != null ? map["isDone"] as bool : null,
      isDeleted: map["isDeleted"] != null ? map["isDeleted"] as bool : null,
    );
  }

  Task copyWith({
    String? title,
    String? description,
    String? id,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      description: description ?? this.description,
      title: title ?? this.title,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
