import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  bool completed = false;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    title = widget.task.title;
    description = widget.task.description ?? '';
    completed = widget.task.completed;
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      widget.task.title = title;
      widget.task.description = description;
      widget.task.completed = completed;
      await apiService.updateTask(widget.task);
      Navigator.pop(context, true); // devolvemos true para refrescar la lista
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Título'),
                onChanged: (value) => title = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Descripción'),
                onChanged: (value) => description = value,
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Completada'),
                value: completed,
                onChanged: (value) => setState(() => completed = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
