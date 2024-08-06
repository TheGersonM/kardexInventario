import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
   Home_Page({
    super.key,
  });
  bool visible = false;
  @override
  State<Home_Page> createState() => _HomePageState();
}

class _HomePageState extends State<Home_Page> {


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ), body:   const Center(child: 
      Text('hola'),
      ),
    );
      
  }
}
