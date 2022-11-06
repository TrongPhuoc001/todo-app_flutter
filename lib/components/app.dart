import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/components/screen/all_screen.dart';
import 'package:todo_app_flutter/components/screen/today_screen.dart';
import 'package:todo_app_flutter/components/screen/upcoming_screen.dart';
import 'package:todo_app_flutter/components/todo/add_todo.dart';
import 'package:todo_app_flutter/components/todo/search_todo.dart';
import 'package:todo_app_flutter/model/todo_model.dart';

import '../services/notification.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late final LocalNotificationService service = LocalNotificationService();
  final _todoBox = Hive.box('todo');
  List<TodoModel> todos = [];
  int tabIndex = 1;

  @override
  void initState() {
    super.initState();
    service.intialize();
    setState(() {
      List todoData = _todoBox.values.toList();
      todos = todoData.map((e) => TodoModel.fromJson(jsonDecode(e))).toList();
    });
    _todoBox.watch().listen((event) {
      setState(() {
        List todoData = _todoBox.values.toList();
        todos = todoData.map((e) => TodoModel.fromJson(jsonDecode(e))).toList();
      });
    });
  }

  void onChangeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      AllScreen(todos, service),
      TodayScreen(todos, service),
      UpcomingScreen(todos, service),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(tab[tabIndex] + " Todo"),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => SearchTodoDialog(todos, service));
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AddTodoDialog(todos, service));
                },
                icon: Icon(Icons.add))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: onChangeTab,
            currentIndex: tabIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "All"),
              BottomNavigationBarItem(icon: Icon(Icons.today), label: "Today"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upcoming), label: "Upcoming"),
            ]),
        body: Center(
          child: screens[tabIndex],
        ));
  }
}

List<String> tab = ["All", "Today", "Upcoming"];
