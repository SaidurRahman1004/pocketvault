import 'package:flutter/material.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/CenterCircularProgressIndicator.dart';
import '../../../widgets/custo_snk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 100, color: Colors.teal),
                const SizedBox(height: 20),
                const Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                CustomTextField(
                  controller: _usernameController,
                  lableText: "Username",
                  hintText: "Enter your username",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter username";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: _passwordController,
                  lableText: "Password",
                  hintText: "Enter your password",
                  icon: Icons.lock,
                  obscureText: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                if (_isLoading) const CenterCircularProgressIndicator(),

                const SizedBox(height: 10),
                Visibility(
                  visible: !_isLoading,
                  child: CustomButton(
                    buttonName: "Login",
                    icon: Icons.login,
                    color: Colors.teal,
                    onPressed: () {
                    },
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    mySnkmsg("Redirecting to Register...", context);
                  },
                  child: const Text("Don't have an account? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}