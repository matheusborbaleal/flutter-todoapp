import 'package:flutter/material.dart';
import 'package:todoapp/components/todo_form.dart';
import 'package:todoapp/models/todo_item.dart';

class ToDoFormPage extends StatelessWidget {
  const ToDoFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ToDoItem? todoItem =
        ModalRoute.of(context)?.settings.arguments as ToDoItem?;

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: todoItem == null ? const Text('New task') : Text(todoItem.title),
        elevation: 0,
        backgroundColor: Colors.yellow[200],
      ),
      body: ToDoForm(),
    );
  }
}
