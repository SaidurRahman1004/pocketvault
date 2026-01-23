import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/CenterCircularProgressIndicator.dart';
import '../../../widgets/custo_snk.dart';
import '../providers/auth_provider.dart';

class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      bool signUpSuccess = await authProvider.signUp(
        _usernameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        if (signUpSuccess) {
          mySnkmsg('Sign Up Success', context);
          Navigator.pop(context);
        } else {
          mySnkmsg('Sign Up Failed', context);
        }
      }
    } catch (e) {
      if (mounted) {
        mySnkmsg('Sign Up Failed: $e', context);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                const Icon(
                  Icons.person_add_outlined,
                  size: 100,
                  color: Colors.teal,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _emailController,
                  lableText: "Email",
                  hintText: "Enter your email",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter email";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _usernameController,
                  lableText: "Username",
                  hintText: "Enter your username",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please enter username";
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
                    if (value == null || value.isEmpty)
                      return "Please enter password";
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Visibility(
                  visible: !_isLoading,
                  replacement: const CenterCircularProgressIndicator(),
                  child: CustomButton(
                    buttonName: "Sign Up",
                    icon: Icons.how_to_reg,
                    color: Colors.teal,
                    onPressed: () {
                      _submit();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
