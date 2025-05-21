import 'package:flutter/material.dart';
import 'package:todoapp/models/mock_data.dart';
import 'package:todoapp/models/todo_item.dart';

class ToDoItemsProvider with ChangeNotifier {
  final List<ToDoItem> _items = ToDoItems;

  List<ToDoItem> get items => [..._items];

  void addItem(ToDoItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(ToDoItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateItem(int index, ToDoItem item) {
    _items[index] = item;
    notifyListeners();
  }
}
