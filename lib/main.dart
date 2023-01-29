import 'package:flutter/material.dart';

import 'package:movies/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas App',
      initialRoute: 'home',
      routes: {
        'home':(_) => HomeScreen(),
        'details':(_) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.green,
          elevation: 0,
          
        )
      ),
    );
  }
}