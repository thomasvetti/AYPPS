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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const TaskListScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/add') {
          return MaterialPageRoute(builder: (_) => const AddTaskScreen());
        } else if (settings.name == '/edit') {
          final task = settings.arguments as Task;
          return MaterialPageRoute(builder: (_) => EditTaskScreen(task: task));
        }
        return null;
      },
    );
  }
}
