import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/pages/login_page.dart';
import 'package:tktodo/repositories/auth/auth_repository.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/register";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "TKTodo",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.red[900],
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.red[900],
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration:
                      const InputDecoration(labelText: "Enter your Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _passwordController,
                  decoration:
                      const InputDecoration(labelText: "Enter your password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length <= 6) {
                      return "Password must be longer than 6 characters";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  isValid
                      ? await context
                          .read<AuthRepository>()
                          .signUp(
                              username: _emailController.text,
                              password: _passwordController.text)
                          .whenComplete(() => Navigator.of(context)
                              .pushReplacementNamed(LoginPage.routeName))
                      : showDialog(
                          context: context,
                          builder: (context) => const Dialog(
                                child: Text("Something went wrong"),
                              ));
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
