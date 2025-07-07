import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final todos = widget.todos;

    return Scaffold(
      backgroundColor: const Color(0xFFFCEEFF),
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: todos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.space_bar_rounded, size: 120, color: Colors.deepPurple),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "There are no TODOs click the plus button to add one.",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: todos[index],
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        onPressed: () async {
          final newTodo = await Navigator.pushNamed(context, '/add');

          if (newTodo != null && newTodo is Todo) {
            setState(() {
              widget.todos.add(newTodo);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
