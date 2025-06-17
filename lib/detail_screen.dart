import 'package:flutter/material.dart';
import 'package:simple_todo0/Todo.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;

    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Center(
        child: Text("Hey I'm ${todo.title}", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
