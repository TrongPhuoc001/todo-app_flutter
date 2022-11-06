import 'dart:convert';

class TodoModel {
  int id;
  String content;
  DateTime createdAt;
  bool isDone;

  TodoModel({
    required this.id,
    required this.content,
    required this.createdAt,
    this.isDone = false,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        createdAt = DateTime.parse(json['createdAt']),
        isDone = json['isDone'];

  toJsonString() {
    return jsonEncode({
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'isDone': isDone,
    });
  }
}
