// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as authentication;
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tktodo/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final BuildContext context;
  final authentication.FirebaseAuth auth;
  AuthRepository({
    required this.context,
    required this.auth,
  });
  @override
  Future<void> signUp(
      {required String username, required String password}) async {
    auth
        .createUserWithEmailAndPassword(email: username, password: password)
        .then((value) {
      log("Value: $value");
    });
  }

  @override
  Future<void> logIn(
      {required String username, required String password}) async {
    try {
      auth
          .signInWithEmailAndPassword(
        email: username,
        password: password,
      )
          .then((value) {
        GetStorage().write("token", value.user!.uid);
        GetStorage().write("email", value.user!.email);
        log("User Token: ${GetStorage().read("token")} from storage");
      });
      //     .onError((error, stackTrace) {
      //   var snackbar =
      //       SnackBar(content: Text("Error: $error, Stack: $stackTrace"));
      //   return ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // }).then((value) {
      //   log("Value: $value");
      // });
    } on FirebaseException catch (error) {
      (context.mounted)
          ? ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())))
          : log("Error: ${error.message}");
    }
  }

  @override
  Future<void> reNemPass({required String username}) async {
    try {
      auth.sendPasswordResetEmail(email: username);
    } on FirebaseException catch (err) {
      log(err.message.toString());
    }
  }

  @override
  Future<void> signOut() async {
    auth.signOut();
  }
}
