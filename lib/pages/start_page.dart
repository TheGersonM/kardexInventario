import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StartPage extends StatefulWidget {
   StartPage({
    super.key,
  });
  bool visible = false;
  @override
  State<StartPage> createState() => _StartPage();
}
class _StartPage extends State<StartPage> {
  late ArticlesDataSource dataArticulos;

  @override
  void initState() {
    super.initState();
    dataArticulos = ArticlesDataSource(ArticlesData: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kardex de inventario', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
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

class ArticlesDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];

  ArticlesDataSource({required List<Articles> ArticlesData}) {
    updateData(ArticlesData);
  }

  void updateData(List<Articles> ArticlesData) {
    dataGridRows = ArticlesData.map<DataGridRow>((article) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: article.id),
      DataGridCell<String>(columnName: 'descripcion', value: article.descripcion),
      DataGridCell<int>(columnName: 'precio', value: article.precio),
      DataGridCell<int>(columnName: 'existencia', value: article.existencia),
      // Añade más celdas según sea necesario
    ])).toList();
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: row.getCells().map<Widget>((cell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(cell.value.toString()),
      );
    }).toList());
  }
}

class Articles {
  Articles(this.id, this.descripcion, this.precio, this.existencia);

  final int id;
  final String descripcion;
  final int precio;
  final int existencia;
}
