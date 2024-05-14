import 'package:flutter/material.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

    );
  }
  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      //name: 'Home',
      name: HomePage.routeName,
      path: '/',
      builder: (context, state) =>  HomePage(),
    )
  ]);
}
