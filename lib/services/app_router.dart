import 'package:flutter/material.dart';
import 'package:tktodo/pages/recycle_bin.dart';
import 'package:tktodo/pages/tasks_page.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBin.routeName:
        return MaterialPageRoute(
          builder: (context) => RecycleBin(),
        );
      case TasksPage.routeName:
        return MaterialPageRoute(builder: (context) => TasksPage());
    }
  }
}
