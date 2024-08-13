import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kardex/models/articles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StartPage extends StatefulWidget {
   const StartPage({
    super.key,
  });
  @override
  State<StartPage> createState() => _StartPage();
}
class _StartPage extends State<StartPage> {
  late ArticulosFuente dataArticulos;

  @override
  void initState() {
    super.initState();
    dataArticulos = ArticulosFuente(dataArticulos: []);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_sharp, color: Colors.white, size: 40),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          
        ],
        title: const Text('Kardex de inventario', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        
        child: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[

                  SizedBox(
                    height: 280,
                    child:  UserAccountsDrawerHeader(
                    
                    accountName:  Text(user?.displayName ?? 'Usuario', style: const TextStyle(color: Colors.white, fontSize: 24)),
                    accountEmail: Text(user?.email ?? 'Correo electronico', style: const TextStyle(color: Colors.white, fontSize: 18)),
                    currentAccountPicture:  CircleAvatar(
                      radius: 40,
                      backgroundImage: user!.photoURL  != null ? NetworkImage(user.photoURL!) : null,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 18, 118, 131),
                      
                    ),
                    
                                    ),
                  ),
                ListTile(
                  title: const Text('Inicio'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'start');
                  },
                ),
                ListTile(
                  title: const Text('Ventas'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'sales');
                  },
                ),
                ListTile(
                  title: const Text('Compras'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'shopping');
                  },
                ),
                ListTile(
                  title: const Text('Salidas de inventario'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'outputs');
                  },
                ),
                ListTile(
                  title: const Text('Entradas de inventario'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'inputs');
                  },
                ),
                ListTile(
                  title: const Text('Artículos'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'articles');
                  },
                ),
              ],
            );
          }
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Articulos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los datos'),
            );
          }

          final data = snapshot.requireData;

          final articulos = data.docs.map((doc) => Articles(
            doc['ArticuloId'],
            doc['Descripcion'],
            doc['precio'],
            doc['Existencia'],
          )).toList();
          articulos.sort((a, b) => a.id.compareTo(b.id));
          dataArticulos.updateData(articulos);

          return SfDataGrid(
            allowSwiping: true,
            onCellDoubleTap: (details) => Navigator.pushNamed(context, 'articles'),
            source: dataArticulos,
            
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridColumn(
                columnName: 'ID',
                label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text('ID'),
                ),
              ),
              GridColumn(
                columnName: 'Descripcion',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Descripcion'),
                ),
              ),
              GridColumn(
                columnName: 'Precio',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Precio'),
                ),
              ),
              GridColumn(
                columnName: 'Existencia',
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Existencia'),
                ),
              ),
            ],
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 107, 174, 229),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      title: const Text('Crear artículo'),
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
