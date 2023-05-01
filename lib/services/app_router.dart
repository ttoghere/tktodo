import 'package:flutter/material.dart';
import 'package:tktodo/pages/completed_page.dart';
import 'package:tktodo/pages/favorite_page.dart';
import 'package:tktodo/pages/pending_page.dart';
import 'package:tktodo/pages/recycle_bin.dart';
import 'package:tktodo/pages/tabs_page.dart';
import 'package:tktodo/pages/tasks_page.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBin.routeName:
        return MaterialPageRoute(builder: (context) => RecycleBin());
      case TasksPage.routeName:
        return MaterialPageRoute(builder: (context) => const TasksPage());
      case TabsPage.routeName:
        return MaterialPageRoute(builder: (context) =>  TabsPage());
      case PendingPage.routeName:
        return MaterialPageRoute(builder: (context) => const PendingPage());
      case FavoritePage.routeName:
        return MaterialPageRoute(builder: (context) => const FavoritePage());
      case CompletedPage.routeName:
        return MaterialPageRoute(builder: (context) => const CompletedPage());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Error Page"),
                      ],
                    ),
                  ),
                ));
    }
  }
}
