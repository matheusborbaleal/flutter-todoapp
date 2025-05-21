import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/todo_list.dart';
import 'package:todoapp/providers/todo_items_provider.dart';
import 'package:todoapp/routes.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    final toDoListProvider = Provider.of<ToDoItemsProvider>(context);
    final toDoList = toDoListProvider.items;

    void goToEditItem(index) {
      Navigator.pushNamed(context, Routes.FORM, arguments: toDoList[index]);
    }

    void deleteItem(index) {
      toDoListProvider.removeItem(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tarefa removida com sucesso!'),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: const Text('Tasks'),
        elevation: 0,
        backgroundColor: Colors.yellow[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.FORM);
        },
        backgroundColor: Colors.yellow[200],
        child: const Icon(Icons.add),
      ),
      body: ToDoList(toDoList, goToEditItem, deleteItem),
    );
  }
}
