import 'package:flutter/material.dart';

import '../../model/todo_model.dart';
import '../todo/todo_list.dart';

Widget TodayScreen(List<TodoModel> todos, service) {
  List<TodoModel> todayTodos =
      todos.where((todo) => todo.createdAt.day == DateTime.now().day).toList();
  return TodoList(todayTodos, service);
}
