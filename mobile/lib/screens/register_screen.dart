import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String? message;

  // Cambia a localhost o 10.0.2.2 según tu entorno http://10.0.2.2:3000/ http://localhost:3000/users/register
  static const String baseUrl = 'http://10.0.2.2:3000/users/register';

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
      message = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        isLoading = false;
        message = "Por favor, completa todos los campos.";
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          message = "Usuario registrado con éxito 🎉";
        });

        // Espera un poco y vuelve al login
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        setState(() {
          message = "Error al registrar. Puede que el correo ya exista.";
        });
      }
    } catch (e) {
      setState(() {
        message = "Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Usuario"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Crear una nueva cuenta",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                if (message != null)
                  Text(
                    message!,
                    style: TextStyle(
                      color: message!.contains("éxito")
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                const SizedBox(height: 20),

                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                        ),
                        child: const Text("Registrar"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
