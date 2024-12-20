import 'package:flutter/material.dart';
import 'package:test/components/avatar.dart';
import 'package:test/components/input_widget.dart';
import 'package:test/components/modern_toast.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TEST APP",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            surface: Colors.black,
            background: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LOG IN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ModernToast toast = ModernToast();

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Perform login logic
    if (email.isEmpty || password.isEmpty) {
      toast.showToast(context, "Failed", "Email or Password cannot be empty!",
          ToastificationType.error);
      return;
    }

    toast.showToast(context, "Success", "Email: $email, Password:$password",
        ToastificationType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: <Widget>[
            Avatar(primaryColor: Colors.grey, imagePath: "images/profile.png"),
            const SizedBox(height: 20), // Add spacing between widgets
            InputWidget(
              inputController: emailController,
              inputType: "email",
              isPassword: false,
            ),
            InputWidget(
              inputController: passwordController,
              inputType: "password",
              isPassword: true,
            ),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text("LOG IN"),
            )
          ],
        ),
      ),
    );
  }
}
