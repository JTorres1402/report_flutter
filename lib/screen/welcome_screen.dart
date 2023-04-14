import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Inicio',
            style: TextStyle(fontSize: 27),
          ),
        ),
      ),
      body: const Center(
        child: Text('welcome'),
      ),
    );
  }
}
