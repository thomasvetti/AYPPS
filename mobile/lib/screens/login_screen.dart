import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  // 🔗 URL de tu backend local
  static const String baseUrl =
      'http://10.0.2.2:3000/auth/login'; // http://10.0.2.2:3000/auth/login http://localhost:3000/auth/login

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = "Por favor, completa todos los campos";
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
        final data = jsonDecode(response.body);
        final token = data['access_token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Ignora la pantalla actual y navega a la principal
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/tasks');
        }
      } else {
        setState(() {
          errorMessage = "Credenciales inválidas o error de conexión.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: ${e.toString()}";
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
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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

                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 20),

                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: loginUser,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 15,
                          ),
                        ),
                        child: const Text("Ingresar"),
                      ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text("¿No tienes cuenta? Regístrate aquí"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
