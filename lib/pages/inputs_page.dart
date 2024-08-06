import 'package:flutter/material.dart';

void main() => runApp(const InputsPage());

class InputsPage extends StatelessWidget {
  const InputsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inputs'),
      ),
      body: const Center(
        child: Text('Inputs Page'),
      ),
    );
  }
}