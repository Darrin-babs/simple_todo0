import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:simple_todo/todo_screen.dart';
import 'package:simple_todo/detail_screen.dart';
import 'package:simple_todo/add_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TodoScreen(
        todos: List.generate(
          10,
          (i) => Todo(title: 'Todo $i', description: 'Description for Todo $i', done: false),
        ),
      ),
      routes: {
        '/detail': (context) => const DetailScreen(),
        '/add': (context) => const AddTodo(),
      },
    );
  }
}
