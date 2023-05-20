import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tktodo/app_theme.dart';
import 'package:tktodo/bloc_folder/bloc_shelf.dart';
import 'package:tktodo/pages/splash_page.dart';
import 'package:tktodo/repositories/auth/auth_repository.dart';
import 'package:tktodo/repositories/tasks/task_repository.dart';
import 'package:tktodo/services/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) =>
                AuthRepository(context: context, auth: FirebaseAuth.instance)),
        RepositoryProvider(create: (context) => TaskRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  TaskBlocBloc(taskRepository: context.read<TaskRepository>())),
          BlocProvider(create: (context) => SwitchBloc()),
        ],
        child: BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Material App',
              debugShowCheckedModeBanner: false,
              theme: state.switchValue
                  ? AppThemes.appThemeData[AppTheme.darkTheme]
                  : AppThemes.appThemeData[AppTheme.lightTheme],
              initialRoute: SplashScreen.routeName,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
