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
          title: const Text('Crear Articulo',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre del articulo',
                  suffixIcon: Icon(Icons.description),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: costoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Costo',
                  suffixIcon: Icon(Icons.attach_money),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
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
                try {
                  final articulosRef =
                      FirebaseFirestore.instance.collection('Articulos');
                  final snapshot = await articulosRef
                      .orderBy('ArticuloId', descending: true)
                      .limit(1)
                      .get();

                  int nuevoArticuloID =
                      1; 

                  if (snapshot.docs.isNotEmpty) {
                    final maxArticuloID = snapshot.docs.first['ArticuloId'];
                    nuevoArticuloID = maxArticuloID + 1;
                  }

                  // Crear el nuevo artículo con el nuevo ArticuloID
                  final articulo = {
                    'ArticuloId': nuevoArticuloID,
                    'Descripcion': nombreController.text,
                    'costo': int.parse(costoController.text),
                    'precio': int.parse(precioController.text),
                    'Existencia': 0,
                  };

                  // Guardar en Firebase
                  await articulosRef.add(articulo);

                  // Volver atrás
                  Navigator.pop(context);
                } catch ( execption) { 
                  // Manejar errores
                  print('Error al crear el artículo: $execption');
                }
              },
              child: const Text('Crear artículo',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ));
  }
}
