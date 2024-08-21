import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KardexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kardex'),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Articulos').snapshots(),
            builder: (context, snapshot) {
              try {
                final docs = snapshot.data?.docs;
                final articulo =
                    docs?.firstWhere((element) => element['ArticuloId'] == id);
                return Center(
                  child: Column(
                    children: [
                      Text(articulo?['nombre'] ?? 'No encontrado'),
                      Text(articulo?['descripcion']),
                      Text(articulo?['precio'].toString() ?? 'No encontrado'),
                      Text(articulo?['stock'].toString() ?? 'No encontrado'),
                    ],
                  ),
                );
              } catch (e) {
                return const Center(
                  child: Text('Error al cargar los datos'),
                );
              }
            }));
  }
}
