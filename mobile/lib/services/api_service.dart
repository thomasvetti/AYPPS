import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

//https://aypps.onrender.com/tasks
// http://10.0.2.2:3000/tasks // Emulador Android
// http://localhost:3000/tasks // Red local
class ApiService {
  static const String baseUrl = 'http://localhost:3000/tasks';
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar las tareas');
    }
  }

  Future<Task> createTask(String title, String description) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'description': description}),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear la tarea');
    }
  }

  Future<void> updateTask(Task task) async {
    await http.patch(
      Uri.parse('$baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
  }

  Future<void> deleteTask(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
