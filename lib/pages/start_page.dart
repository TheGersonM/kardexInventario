import 'package:flutter/material.dart';

void main() => runApp(const Start_page());

class Start_page extends StatefulWidget {
  const Start_page({super.key});

  @override
  State<Start_page> createState() => _Start_pageState();
}

class _Start_pageState extends State<Start_page> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Kardex de inventario', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          
          backgroundColor: const Color.fromARGB(255, 107, 174, 229),
          onPressed: () {
            //Navigator.pushNamed(context, 'home');

            //Desplegar 4 botones en forma vertical con un texto lateral tomando en cuenta el safe zone
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  
                  child: ListView(
                    
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.point_of_sale),
                        title: const Text('Registrar Venta'),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'sales');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_shopping_cart),
                        title: const Text('Registrar compra'),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'shopping');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.remove),
                        title: const Text('Registrar salida de inventario'),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'outputs');  
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('Registrar entrada de inventario'),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'inputs');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_to_photos),
                        title: const Text('Crear articulo'),
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'articles');
                        },
                      ),
                    ],
                  ),
                );
              },
            );
            
          },
          child: const Icon(Icons.add_to_photos),
        ),
    );
  }
}