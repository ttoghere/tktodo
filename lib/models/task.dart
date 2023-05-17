// ignore_for_file: public_member_api_docs, sort_constructors_first

import "package:equatable/equatable.dart";

class Task extends Equatable {
  final String title;
  final String id;
  final String description;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;
  Task({
    required this.date,
    required this.description,
    required this.id,
    required this.title,
    this.isDone = false,
    this.isDeleted = false,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        title,
        isDeleted,
        isDone,
        id,
        isFavorite,
        description,
        date,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "date": date,
      "description": description,
      "isFavorite": isFavorite,
      "title": title,
      "id": id,
      "isDone": isDone,
      "isDeleted": isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      date: map["date"] as String,
      isFavorite: map["isFavorite"] != null ? map["isFavorite"] as bool : null,
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
    String? date,
    bool? isFavorite,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      date: date ?? this.date,
      description: description ?? this.description,
      title: title ?? this.title,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isFavorite: isFavorite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
