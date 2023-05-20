import 'package:flutter/material.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/pages/login_page.dart';
import 'package:tktodo/repositories/auth/auth_repository.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = "/forgot-pass";
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController? _emailController;
  GlobalKey<FormState>? _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "TKTodo",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.red[900],
              ),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Forgot password ?",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.red[900],
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Enter Your Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    var result = (value == null || value.isEmpty)
                        ? "Email is Required"
                        : null;
                    return result;
                  },
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    var alpha = _formKey!.currentState!.validate();
                    alpha
                        ? context
                            .read<AuthRepository>()
                            .reNemPass(username: _emailController!.text)
                            .catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")));
                            return;
                          }).then((value) => Navigator.of(context)
                                .pushNamed(LoginPage.routeName))
                        : null;
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    maximumSize: const Size(200, 40),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.message_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Reset Password"),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
