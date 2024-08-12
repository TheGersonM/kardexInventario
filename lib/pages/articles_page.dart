import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ArticlesPage extends StatelessWidget {
   ArticlesPage({super.key});


  final TextEditingController nombreController = TextEditingController();

  final TextEditingController costoController = TextEditingController();

  final TextEditingController precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Articulo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ), body:   Column(
        
        children: [

         Padding(
          padding:  const EdgeInsets.all(16.0),
          child:  TextField(
            controller: nombreController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre del articulo',
              suffixIcon: Icon(Icons.description),
            ),
          ),
        ),
        Padding(
          padding:  const EdgeInsets.all(16.0),
          child:  TextField(
            controller: costoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Costo',
              suffixIcon: Icon(Icons.attach_money),
            ),
          ),
        ),
        Padding(
          padding:  const EdgeInsets.all(16.0),
          child:  TextField(
            controller: precioController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Precio de venta',
              suffixIcon: Icon(Icons.attach_money_rounded),
            ),
          ),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
           onPressed: () async {
                final articulo = {
                  'Descripcion': nombreController.text,
                  'costo': int.parse(costoController.text),
                  'percio': int.parse(precioController.text),
                  'Existencia': 0,
                };
        
                //guardar en firebase
                final articulosRef =
                    FirebaseFirestore.instance.collection('Articulos');
        
                articulosRef.add(articulo);
                Navigator.pop(context);
              },
          child: const Text('Crear articulo', style: TextStyle(color: Colors.white)),
        ),
      ],)
    );
  }
}