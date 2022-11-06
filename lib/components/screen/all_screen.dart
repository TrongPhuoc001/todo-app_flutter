import 'package:flutter/material.dart';
import 'package:todo_app_flutter/components/todo/todo_list.dart';

import '../../model/todo_model.dart';

Widget AllScreen(List<TodoModel> todos, service) {
  return TodoList(todos, service);
}
