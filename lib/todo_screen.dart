import 'package:flutter/material.dart';
import 'package:simple_todo0/Todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            onTap: () {
              // Optional: For debugging
              print('Tapped: ${todos[index].title}');
              
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: todos[index],
              );
            },
          );
        },
      ),
    );
  }
}
