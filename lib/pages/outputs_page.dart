import 'package:flutter/material.dart';

void main() => runApp(const OutputsPage());

class OutputsPage extends StatefulWidget {
  const OutputsPage({super.key});

  @override
  State<OutputsPage> createState() => _OutputsPageState();
}

class _OutputsPageState extends State<OutputsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outputs'),
      ),
      body: const Center(
        child: Text('Outputs Page'),
      ),
    );
  }
}