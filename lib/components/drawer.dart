import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String errorMessage = '';
  bool isSwitched = false;

  void signOutFromFirebase() async {
    try {
      await FirebaseAuth.instance.signOut().then(
            (value) => Navigator.of(context).pushReplacementNamed('/login'),
          );
    } on FirebaseException catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1512070750041-b9479c107194?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1305&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Not Netflix',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomLeft,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 25),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.red,
                      ),
                      onPressed: () {
                        signOutFromFirebase();
                      },
                      child: const Text('Log Out'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 10),
                    child: Row(
                      children: [
                        /*  Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(Theme.of(context));
                              if (value) {
                                AdaptiveTheme.of(context).setDark();
                              } else {
                                AdaptiveTheme.of(context).setLight();
                              }
                            });
                          },
                        ), */

                        if (Theme.of(context).toString() ==
                            'ThemeData#8ffb5') ...[
                          TextButton(
                              onPressed: () {
                                print(Theme.of(context));
                                AdaptiveTheme.of(context).setDark();
                              },
                              child: const Icon(Icons.dark_mode, size: 14))
                        ] else ...[
                          TextButton(
                              onPressed: () {
                                print(Theme.of(context));
                                AdaptiveTheme.of(context).setLight();
                              },
                              child: const Icon(Icons.sunny, size: 14))
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
