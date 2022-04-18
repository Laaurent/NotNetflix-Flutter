import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:not_netflix/components/drawer.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  dynamic user;
  late Future promise;

  late String userEmail;
  late String userVerified;
  late String userCreatedAt;

  getCurrentUserEmail() async {
    user = _auth.currentUser;
    await user?.reload();
    user = _auth.currentUser;
    setState(() {
      userEmail = user.email;
      userVerified = user.emailVerified ? 'Verifié' : 'Non verifié';
      userCreatedAt =
          DateFormat('yyyy-MM-dd – kk:mm').format(user.metadata.creationTime);
    });
    return user;
  }

  @override
  void initState() {
    super.initState();
    promise = getCurrentUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: promise,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return Scaffold(
              body: ListView(
                children: [
                  /*  Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: Text(user.toString())), */
                  ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(userEmail)),
                  ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(userVerified)),
                  ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Date de création'),
                      subtitle: Text(userCreatedAt)),
                ],
              ),
            );
          }
          return Container();
        }));
  }
}

/* return Scaffold(
      body: ListView(
        children: [
          Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(user.toString())),
          const ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('test')),
        ],
      ),
    ) */
