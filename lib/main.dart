import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  final String title;
  final String description;
  final bool done;

  const Todo({
    required this.title,
    required this.description,
    required this.done,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json['title'],
        description: json['description'],
        done: json['done'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'done': done,
      };
}

class TodoStorage {
  static const _storageKey = 'todo';

  static Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(todos.map((t) => t.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }

  static Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Todo.fromJson(e)).toList();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> _todos = [];
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final loaded = await TodoStorage.loadTodos();
    setState(() {
      _todos = loaded;
    });
  }

  void _addTodo() {
    final title = _titleController.text.trim();
    final description = _descController.text.trim();
    if (title.isEmpty || description.isEmpty) return;
    final newTodo = Todo(title: title, description: description, done: false);
    setState(() {
      _todos.add(newTodo);
    });
    TodoStorage.saveTodos(_todos);
    _titleController.clear();
    _descController.clear();
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index] = Todo(
        title: _todos[index].title,
        description: _todos[index].description,
        done: !_todos[index].done,
      );
    });
    TodoStorage.saveTodos(_todos);
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
    TodoStorage.saveTodos(_todos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Add Todo'),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  leading: Checkbox(
                    value: todo.done,
                    onChanged: (_) => _toggleDone(index),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
