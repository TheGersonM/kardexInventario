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
        title: const Text('Kardex de inventario',
            style: TextStyle(color: Colors.white)),
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
                    child: UserAccountsDrawerHeader(
                      accountName: Text(user?.displayName ?? 'Usuario',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24)),
                      accountEmail: Text(user?.email ?? 'Correo electronico',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                      currentAccountPicture: CircleAvatar(
                        radius: 40,
                        backgroundImage: user!.photoURL != null
                            ? NetworkImage(user.photoURL!)
                            : null,
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
            }),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Doble tap en el articulo para ver el kardex',
              style: TextStyle(fontSize: 15)),
          const SizedBox(height: 20),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Articulos').snapshots(),
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

              final articulos = data.docs
                  .map((doc) => Articles(
                        doc['ArticuloId'],
                        doc['Descripcion'],
                        doc['precio'],
                        doc['Existencia'],
                      ))
                  .toList();
              articulos.sort((a, b) => a.id.compareTo(b.id));
              dataArticulos.updateData(articulos);

              return SfDataGrid(
                allowSwiping: true,
                onCellDoubleTap: (details) {
                  int rowIndex = details.rowColumnIndex.rowIndex -
                      1; // El índice de la fila (resta 1 si tienes un header)
                  var dataGridRow = dataArticulos.rows[rowIndex];

                  // Obtén el valor de la primera columna
                  var firstColumnValue = dataGridRow.getCells()[0].value;

                  // Navega a la nueva página pasando el valor como argumento
                  Navigator.pushNamed(context, 'kardex',
                      arguments: firstColumnValue);
                },
                source: dataArticulos,
                columnWidthMode: ColumnWidthMode.fill,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'Id',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('Id'),
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
        ],
      ),
    );
  }
}
