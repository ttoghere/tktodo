import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/pages/forgot_pass_page.dart';
import 'package:tktodo/pages/register_page.dart';
import 'package:tktodo/pages/tabs_page.dart';
import 'package:tktodo/repositories/auth/auth_repository.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TKTodo",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.red[900],
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _emailController,
                  decoration:
                      const InputDecoration(labelText: "Enter your email"),
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
                  controller: _passwordControler,
                  decoration:
                      const InputDecoration(labelText: "Enter your password"),
                  keyboardType: TextInputType.emailAddress,
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
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  isValid
                      ? context
                          .read<AuthRepository>()
                          .logIn(
                              username: _emailController.text,
                              password: _passwordControler.text)
                          .onError((error, stackTrace) {})
                          .then((value) {
                          Navigator.of(context)
                              .pushReplacementNamed(TabsPage.routeName);
                        }).onError((error, stackTrace) {
                          var snackbar = SnackBar(
                              content:
                                  Text("Error: $error, Stack: $stackTrace"));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }).then((value) {
                          log("Value: $value");
                        })
                      : null;
                },
                child: const Text("Login"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterPage.routeName);
                  },
                  child: const Text("Don't have an account?")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ForgotPasswordPage.routeName);
                  },
                  child: const Text("Don't remember the password?"))
            ],
          ),
        ),
      ),
    );
  }
}
