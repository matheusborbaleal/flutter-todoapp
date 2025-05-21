import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_item.dart';
import 'package:todoapp/components/todo_item.dart';

class ToDoList extends StatelessWidget {
  final List<ToDoItem> todoItems;
  final Function editItem;
  final Function deleteItem;

  const ToDoList(this.todoItems, this.editItem, this.deleteItem, {super.key});

  Widget buildToDoList(int index) {
    ToDoItem todoItem = todoItems[index];
    return ToDoTask(
      toDoItem: todoItem,
      editItem: () => editItem(index),
      deleteItem: () => deleteItem(todoItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        return buildToDoList(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
