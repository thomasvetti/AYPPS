import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = apiService.fetchTasks();
  }

  Future<void> _refreshTasks() async {
    setState(() {
      futureTasks = apiService.fetchTasks();
    });
  }

  void _deleteTask(int id) async {
    await apiService.deleteTask(id);
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de Tareas'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: _refreshTasks,
        child: FutureBuilder<List<Task>>(
          future: futureTasks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay tareas registradas'));
            } else {
              final tasks = snapshot.data!;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Icon(
                        task.completed
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: task.completed ? Colors.green : Colors.grey,
                        size: 30,
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle:
                          task.description != null &&
                              task.description!.isNotEmpty
                          ? Text(
                              task.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: task,
                        );
                        if (result == true) _refreshTasks();
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await apiService.deleteTask(task.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tarea eliminada')),
                          );
                          _refreshTasks();
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add');
          if (result == true) _refreshTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
