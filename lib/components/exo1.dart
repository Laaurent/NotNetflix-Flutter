import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Exo1 extends HookWidget {
  const Exo1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Color> red = useState(Colors.red);
    ValueNotifier<Color> green = useState(Colors.green);
    ValueNotifier<Color> blue = useState(Colors.blue);
    ValueNotifier<Color> yellow = useState(Colors.yellow);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                red.value = Colors.red;
                green.value = Colors.red;
                blue.value = Colors.red;
                yellow.value = Colors.red;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 50,
                width: 50,
                color: red.value,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                red.value = Colors.green;
                green.value = Colors.green;
                blue.value = Colors.green;
                yellow.value = Colors.green;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 50,
                width: 50,
                color: green.value,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                blue.value = Colors.blue;
                green.value = Colors.blue;
                red.value = Colors.blue;
                yellow.value = Colors.blue;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 50,
                width: 50,
                color: blue.value,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                yellow.value = Colors.yellow;
                green.value = Colors.yellow;
                red.value = Colors.yellow;
                blue.value = Colors.yellow;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 50,
                width: 50,
                color: yellow.value,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 75,
          child: ElevatedButton(
            onPressed: () {
              red.value = Colors.red;
              green.value = Colors.green;
              blue.value = Colors.blue;
              yellow.value = Colors.yellow;
            },
            child: const Text('Reset'),
          ),
        ),
      ],
    );
  }
}
