import 'package:flutter/material.dart';
import 'package:todo_app_flutter/components/todo/todo_list.dart';
import 'package:todo_app_flutter/model/todo_model.dart';

class SearchTodoDialog extends StatefulWidget {
  List<TodoModel> todos;
  var service;
  SearchTodoDialog(this.todos, this.service, {Key? key}) : super(key: key);
  @override
  _SearchTodoDialogState createState() => _SearchTodoDialogState();
}

class _SearchTodoDialogState extends State<SearchTodoDialog> {
  List<TodoModel> searchTodos = [];

  @override
  void initState() {
    super.initState();
    searchTodos = widget.todos;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search Todo'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                searchTodos = widget.todos
                    .where((todo) => todo.content.contains(value))
                    .toList();
              });
            },
          ),
          Expanded(
              child: Container(
            width: double.maxFinite,
            child: TodoList(searchTodos, widget.service),
          ))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
