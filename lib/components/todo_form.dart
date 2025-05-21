import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/geo_point.dart';
import 'package:todoapp/models/todo_item.dart';
import 'package:todoapp/providers/todo_items_provider.dart';

import 'package:geolocator/geolocator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ToDoForm extends StatelessWidget {
  final taskNameController = TextEditingController();
  final taskDateController = TextEditingController();
  final taskLocationController = TextEditingController();

  ToDoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final todoItemsProvider = Provider.of<ToDoItemsProvider>(
      context,
      listen: false,
    );

    final ToDoItem? todoItem =
        ModalRoute.of(context)?.settings.arguments as ToDoItem?;

    var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/#### ##:##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    if (todoItem != null) {
      taskNameController.text = todoItem.title;
      taskDateController.text = todoItem.taskDate;
      taskLocationController.text =
          '${todoItem.location?.latitude}, ${todoItem.location?.longitude}';
    }

    Future<Position> getLocation() async {
      bool isEnabled = await Geolocator.isLocationServiceEnabled();
      if (isEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied ||
              permission == LocationPermission.deniedForever) {
            return Future.error("Serviço de localização negado.");
          }
        }
        Position position = await Geolocator.getCurrentPosition();
        if (todoItem == null) {
          taskLocationController.text =
              '${position.latitude}, ${position.longitude}';
        }
        return position;
      } else {
        return Future.error("Serviço de localização desativado.");
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: FutureBuilder(
        future: getLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              spacing: 30,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: taskNameController,
                  decoration: const InputDecoration(labelText: 'Task Name'),
                ),
                TextField(
                  controller: taskLocationController,
                  decoration: const InputDecoration(labelText: 'Task Location'),
                  enabled: false,
                ),
                TextField(
                  controller: taskDateController,
                  decoration: const InputDecoration(
                    labelText: 'Type a date and hour',
                  ),
                  inputFormatters: [maskFormatter],
                  keyboardType: TextInputType.datetime,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (todoItem != null) {
                      todoItemsProvider.updateItem(
                        todoItemsProvider.items.indexOf(todoItem),
                        ToDoItem(
                          title: taskNameController.text,
                          taskDate: taskDateController.text,
                          location: GeoPoint(
                            latitude: todoItem.location!.latitude,
                            longitude: todoItem.location!.longitude,
                          ),
                        ),
                      );
                    } else {
                      todoItemsProvider.addItem(
                        ToDoItem(
                          title: taskNameController.text,
                          taskDate: taskDateController.text,
                          location: GeoPoint(
                            latitude: snapshot.data!.latitude,
                            longitude: snapshot.data!.longitude,
                          ),
                        ),
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
