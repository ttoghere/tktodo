import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tktodo/pages/login_page.dart';
import 'package:tktodo/pages/tabs_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage _getStorage = GetStorage();
  @override
  void initState() {
    super.initState();
    _openNextPage();
  }

  void _openNextPage() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_getStorage.read("token") == null ||
          _getStorage.read("token") == "") {
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(TabsPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
