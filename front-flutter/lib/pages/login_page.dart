import 'package:csm_front/pages/home_page.dart';
import 'package:csm_front/services/api_instance.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login(context) async {
    final res = await api.post(
      '/login',
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    final token = res.data['token'];

    api.options.headers['Authorization'] = 'Bearer $token';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyTextField(emailController: emailController, hint: "Email"),
          MyTextField(emailController: passwordController, hint: "Password"),
          ElevatedButton(
              onPressed: () => _login(context), child: const Text('Login')),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.emailController,
    required this.hint,
  });

  final TextEditingController emailController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        filled: true,
      ),
    );
  }
}
