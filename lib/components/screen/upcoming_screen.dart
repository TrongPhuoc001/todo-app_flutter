import 'package:flutter/material.dart';

import '../../model/todo_model.dart';
import '../todo/todo_list.dart';

Widget UpcomingScreen(List<TodoModel> todos, service) {
  List<TodoModel> upcomingTodos =
      todos.where((todo) => todo.createdAt.day >= DateTime.now().day).toList();
  upcomingTodos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  return TodoList(upcomingTodos, service);
}
