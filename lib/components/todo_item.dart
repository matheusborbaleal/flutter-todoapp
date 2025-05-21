import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_item.dart';

class ToDoTask extends StatelessWidget {
  final ToDoItem toDoItem;
  final Function editItem;
  final Function deleteItem;

  const ToDoTask({
    required this.toDoItem,
    required this.editItem,
    required this.deleteItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(toDoItem.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(toDoItem.taskDate, style: const TextStyle(fontSize: 12)),
          Text(
            '${toDoItem.location?.latitude}, ${toDoItem.location?.longitude}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => editItem()),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => deleteItem(),
          ),
        ],
      ),
    );
  }
}
