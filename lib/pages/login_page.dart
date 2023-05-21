import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return "Email is required";
    }
    //RegExp için tasarım örneği
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return "Invalid email adress";
    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return "Password is required";
    }
    String pattern = r'^.{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(formPassword)) {
      /*
        r'^
          (?=.*[A-Z])       // should contain at least one upper case
          (?=.*[a-z])       // should contain at least one lower case
          (?=.*?[0-9])      // should contain at least one digit
          (?=.*?[!@#\$&*~]) // should contain at least one Special character
          .{8,}             // Must be at least 8 characters in length  
        $ 
       * 
      */
      return '''
			Password must be at least 8 characters,
			''';
    }
    return null;
  }

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
                  validator: validateEmail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _passwordControler,
                  validator: validatePassword,
                  decoration:
                      const InputDecoration(labelText: "Enter your password"),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordControler.text)
                          .then((value) {
                        GetStorage().write("token", value.user!.uid);
                        GetStorage().write("email", value.user!.email);
                        log("User Token: ${GetStorage().read("token")} from storage");
                        Navigator.of(context)
                            .pushReplacementNamed(TabsPage.routeName);
                      });
                    } on FirebaseAuthException catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.message!)));
                    }
                  }
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
