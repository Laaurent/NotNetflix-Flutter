import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:not_netflix/views/home.dart';
import 'firebase_options.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const Home(),
  '/login': (context) => const Scaffold(
        body: Center(
          child: Text('Login'),
        ),
      ),
  '/register': (context) => const Scaffold(
        body: Center(
          child: Text('Register'),
        ),
      ),
};
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Not Netflix',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/',
    );
  }
}
