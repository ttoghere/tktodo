import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  onPressed: () {}, child: const Text("Don't have an account?"))
            ],
          ),
        ),
      ),
    );
  }
}
