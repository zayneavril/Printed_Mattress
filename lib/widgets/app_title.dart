import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String text;

  const AppTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}