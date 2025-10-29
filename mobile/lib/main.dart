import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
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

      // 👇 Punto de entrada de la app (pantalla de login)
      initialRoute: '/',

      routes: {
        '/': (context) => const LoginScreen(),
        '/tasks': (context) => const TaskListScreen(),
        '/add': (context) => const AddTaskScreen(),
        // 👇 esta ruta necesita argumentos, por eso la manejamos manualmente
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final task = settings.arguments as Task;
          return MaterialPageRoute(builder: (_) => EditTaskScreen(task: task));
        }
        return null;
      },
    );
  }
}
