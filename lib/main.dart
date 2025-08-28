import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Features/splash_scren.dart';
import 'package:motives_android_conversion/theme_change/theme_bloc.dart';
import 'package:motives_android_conversion/theme_change/theme_state.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(create: (_) => ThemeBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, state) {
//         return MaterialApp(
//           title: 'Motives-T',
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             brightness: Brightness.light,
//             primarySwatch: Colors.blue,
//             scaffoldBackgroundColor: Colors.white,
//             textTheme: const TextTheme(
//               bodyLarge: TextStyle(color: Colors.black),
//               bodyMedium: TextStyle(color: Colors.black),
//               bodySmall: TextStyle(color: Colors.black),
//             ),
//           ),
//           darkTheme: ThemeData(
//             brightness: Brightness.dark,
//             scaffoldBackgroundColor: Colors.black12,
//             textTheme: const TextTheme(
//               bodyLarge: TextStyle(color: Colors.white),
//               bodyMedium: TextStyle(color: Colors.white),
//               bodySmall: TextStyle(color: Colors.white),
//             ),
//           ),
//           themeMode: state.themeMode,
//           home: SplashScreen(),
//         );
//       },
//     );
//   }
// }

