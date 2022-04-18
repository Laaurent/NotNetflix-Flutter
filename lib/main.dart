import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:not_netflix/components/drawer.dart';
import 'package:not_netflix/routes.dart';
import 'components/detail.dart';
import 'firebase_options.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          AdaptiveTheme(
            light: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              accentColor: Colors.amber,
            ),
            dark: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
              accentColor: Colors.amber,
            ),
            initial: AdaptiveThemeMode.light,
            builder: (theme, darkTheme) => const MaterialApp(
              home: Scaffold(
                body: SafeArea(
                  child: Center(
                    child: Text('Error'),
                  ),
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return AdaptiveTheme(
            light: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              accentColor: Colors.amber,
            ),
            dark: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
              accentColor: Colors.amber,
            ),
            initial: AdaptiveThemeMode.light,
            builder: (theme, darkTheme) => MaterialApp(
              title: 'Flutter',
              theme: theme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              routes: routes,
              initialRoute:
                  FirebaseAuth.instance.currentUser != null ? '/' : '/login',
              onGenerateRoute: (settings) {
                if (settings.name == '/detail') {
                  final args = settings.arguments as Map<String, dynamic>;
                  return MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: const Text('Detail'),
                        //back to previous screen
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      body: Detail(
                        id: args['id'] as int,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          );
        }

        return Container();
      }),
    );
  }
}
