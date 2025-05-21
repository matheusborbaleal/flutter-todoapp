import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/todo_form_page.dart';
import 'package:todoapp/pages/todo_page.dart';
import 'package:todoapp/providers/todo_items_provider.dart';
import 'package:todoapp/routes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ToDoItemsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.LIST: (context) => ToDoPage(),
          Routes.FORM: (context) => ToDoFormPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        ),
      ),
    );
  }
}
