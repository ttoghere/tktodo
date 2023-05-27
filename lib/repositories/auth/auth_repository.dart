// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as authentication;
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tktodo/pages/tabs_page.dart';
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
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: username, password: password)
          .then((value) {
        GetStorage().write("token", value.user!.uid);
        GetStorage().write("email", value.user!.email);
        log("User Token: ${GetStorage().read("token")} from storage");
        Navigator.of(context).pushReplacementNamed(TabsPage.routeName);
      });
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message!)));
    }
    //   auth
    //       .signInWithEmailAndPassword(
    //     email: username,
    //     password: password,
    //   )
    //     .then((value) {
    //   GetStorage().write("token", value.user!.uid);
    //   GetStorage().write("email", value.user!.email);
    //   log("User Token: ${GetStorage().read("token")} from storage");
    // });
    //   errorMessage = "";
    // } on authentication.FirebaseAuthException catch (error) {
    //   errorMessage = error.message!;
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(errorMessage)));
    // }
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


  @override
  Future<void> deleteAccountAndData() async {
    try {
      // Step 1: Delete User Account
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the user's email
        String? userEmail = user.email;

        // Step 2: Delete Firestore Collection
        if (userEmail != null) {
          WriteBatch batch = FirebaseFirestore.instance.batch();

          // Delete user's collection
          DocumentReference userCollectionRef =
              FirebaseFirestore.instance.collection(userEmail).doc();
          batch.delete(userCollectionRef);

          // Delete user account
          batch.delete(userCollectionRef);
          await batch.commit();

          // Step 3: Delete User Account
          await user.delete();
          log('User account and associated data deleted successfully.');
        } else {
          log('User email is not available.');
        }
      } else {
        log('No user is currently signed in.');
      }
    } catch (e) {
      log('Failed to delete account and data: $e');
    }
  }
}
