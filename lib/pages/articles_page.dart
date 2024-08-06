import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const ArticlesPage());

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Articulo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ), body:   Column(
        
        children: [

        const Padding(
          padding:  EdgeInsets.all(16.0),
          child:  TextField(
            
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre del articulo',
              suffixIcon: Icon(Icons.description),
            ),
          ),
        ),
        const Padding(
          padding:  EdgeInsets.all(16.0),
          child:  TextField(
            
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Precio',
              suffixIcon: Icon(Icons.attach_money),
            ),
          ),
        ),
        const Padding(
          padding:  EdgeInsets.all(16.0),
          child:  TextField(
            
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Grupo articulo',
              suffixIcon: Icon(Icons.group_work),
            ),
          ),
        ),
        const Padding(
          padding:  EdgeInsets.all(16.0),
          child:  TextField(
            
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Existencia',
              suffixIcon: Icon(Icons.summarize),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Respond to button press
          },
          child: const Text('Crear'),
        ),
      ],)
    );
  }
}