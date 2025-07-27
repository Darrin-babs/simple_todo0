import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  String title = "";
  String description = "";
  var uuid = Uuid();

  // ignore: recursive_getters
  get descEdit => descEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Title",
              ),
              onChanged: (value) {
                title = value;
              },
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Description",
              ),
              controller: descEdit,
              onChanged: (value) {
                description = value;
              },
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed:() {
              if(title.isEmpty || description.isEmpty) {
                ScaffoldMessenger.of(context)
                ..removeCurrentMaterialBanner()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      "Please enter a title and description for your TODO",
                    ),
                  ),
                );
              } else {
                Todo todo = createTodo(title, description, false);
                Navigator.pop(context, todo);
              }
            }, child: Text("Add TODO"),
          ),
        ],),
      )
    );
  }
  Todo createTodo(String title, String description, bool done) {
    String id = uuid.v1();
    return Todo(title: title, description: description, done: false, id: id);
  }
}