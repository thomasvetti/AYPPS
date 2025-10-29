import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/edit_task_screen.dart';
import 'models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Tareas',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => const TaskListScreen(),
        '/add': (context) => const AddTaskScreen(),
        '/edit': (context) {
          final task = ModalRoute.of(context)!.settings.arguments as Task;
          return EditTaskScreen(task: task);
        },
      },
    );
  }
}
