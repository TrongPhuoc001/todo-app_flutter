import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/todo_model.dart';

Widget TodoList(List<TodoModel> todos, service) {
  var _todoBox = Hive.box('todo');
  return ListView.builder(
    itemCount: todos.length,
    itemBuilder: (context, index) {
      return Dismissible(
        key: Key(todos[index].content),
        onDismissed: (direction) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${todos[index].content} deleted')));
          _todoBox.deleteAt(index);
          service.cancelNotification(todos[index].id);
        },
        background: Container(
          color: Colors.red,
          child: Row(children: [
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ]),
        ),
        child: ListTile(
          title: Text(todos[index].content),
          subtitle: Text(convertedDateTime(todos[index].createdAt)),
          trailing: Checkbox(
            value: todos[index].isDone,
            onChanged: (value) {
              TodoModel newTodo = TodoModel(
                  content: todos[index].content,
                  createdAt: todos[index].createdAt,
                  isDone: !todos[index].isDone,
                  id: todos[index].id);
              _todoBox.putAt(index, newTodo.toJsonString());
              if (newTodo.isDone) {
                service.cancelNotification(newTodo.id);
              } else {
                service.scheduleNotification(newTodo.id, newTodo.content,
                    newTodo.createdAt, newTodo.createdAt);
              }
            },
          ),
        ),
      );
    },
  );
}

convertedDateTime(DateTime now) {
  return "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
}
