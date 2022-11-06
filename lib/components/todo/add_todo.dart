import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/todo_model.dart';
import '../../services/notification.dart';

class AddTodoDialog extends StatefulWidget {
  AddTodoDialog(this.todos, this.service, {super.key}) {}
  final todos;
  final LocalNotificationService service;
  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _todoBox = Hive.box('todo');
  String content = '';
  DateTime createdAt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Todo'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Content"),
          TextField(
            onChanged: (value) {
              setState(() {
                content = value;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2023),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      createdAt = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          createdAt.hour,
                          createdAt.minute);
                    });
                  }
                },
                child: Text('Select Date: ' +
                    createdAt.day.toString() +
                    "-" +
                    createdAt.month.toString()),
              ),
              TextButton(
                  onPressed: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (selectedTime != null) {
                      setState(() {
                        createdAt = DateTime(
                            createdAt.year,
                            createdAt.month,
                            createdAt.day,
                            selectedTime.hour,
                            selectedTime.minute);
                      });
                    }
                  },
                  child: Text('Select time: ' +
                      createdAt.hour.toString() +
                      ":" +
                      createdAt.minute.toString()))
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            TodoModel todo = TodoModel(
                content: content, createdAt: createdAt, id: content.hashCode);
            _todoBox.add(todo.toJsonString());
            widget.service.showScheduledNotification(
                body: todo.content,
                id: todo.id,
                time: todo.createdAt,
                title: 'Todo');
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
