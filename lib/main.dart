import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app_flutter/components/app.dart';

import 'model/todo_model.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('todo');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: App(),
    );
  }
}
