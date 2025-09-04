import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/Features/dashboard_screen.dart';
import 'package:motives_android_conversion/Features/splash_scren.dart';
import 'package:motives_android_conversion/theme_change/theme_bloc.dart';
import 'package:motives_android_conversion/theme_change/theme_state.dart';

final box = GetStorage();
var email = box.read("email");
var password = box.read("password");
var email_auth = box.read("email_auth");
var password_auth = box.read("password-auth");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        BlocProvider<GlobalBloc>(create: (_) => GlobalBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (email != null) {
      Future.microtask(() {
        context.read<GlobalBloc>().add(
          LoginEvent(email: email!, password: password),
        );
      });
    } else if (email_auth != null) {
      context.read<GlobalBloc>().add(
        LoginEvent(email: email_auth, password: password_auth),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Motives-T',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              bodySmall: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black12,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white),
            ),
          ),
          themeMode: state.themeMode,
          home: email != null ? DashboardScreen() : SplashScreen(),
        );
      },
    );
  }
}


  /*       final box = GetStorage();
      var email=  box.read("email");
      var password=  box.read("password");

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
void initState() {
  super.initState();

  if (email != null) {
    Future.microtask(() {
      context.read<GlobalBloc>().add(
        Login(email: email!, password: password),
      );
    });
  }
}
  @override
  Widget build(BuildContext context) {

    
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        BlocProvider<GlobalBloc>(create: (_) => GlobalBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Motives-T',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.black),
                bodySmall: TextStyle(color: Colors.black),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black12,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white),
              ),
            ),
            themeMode: state.themeMode,
            home: email != null ?
             DashboardScreen(): SplashScreen(),
          );
        },
      ),
    );
  }
}
*/