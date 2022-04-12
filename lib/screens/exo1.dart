import 'package:flutter/material.dart';
import 'package:not_netflix/components/exo1.dart';

class Exo1Screen extends StatelessWidget {
  const Exo1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Exo1(),
      ),
    );
  }
}
