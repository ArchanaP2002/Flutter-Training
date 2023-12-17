// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'const.dart';

void main() {}

class Loginclass extends StatelessWidget {
  const Loginclass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(FoodImage),
          const Text("Food Login"),
          const Text("Login Please")
        ],
      ),
    );
  }
}
