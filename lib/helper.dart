import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> serializeTODO(List<String> savedTodo, List<Todo> todos) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (savedTodo.isNotEmpty) {
    savedTodo.clear();
  }

  for (int i = 0; i < todos.length; i++) {
    String todo = json.encode(todos[i]);
    savedTodo.add(todo);
  }
  await prefs.setStringList("TODO", savedTodo);
}

Future<List<Todo>> deserializeTODO() async {
  List<String> savedTodo;
  List<Todo> todos = [];

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var fromMem = prefs.getStringList("TODO");
  if (fromMem != null) {
    savedTodo = fromMem;
    for (int i = 0; i < savedTodo.length; i++) {
      Map<String, dynamic> todo = json.decode(savedTodo[i]);
      todos.add(Todo.fromJson(todo));
    }
  }

  return todos;
}
