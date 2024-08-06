import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:kardex/models/articles.dart';

void main() => runApp(const StartPage());

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Articles> articulos = <Articles>[];
  late ArticlesDataSource dataArticulos;

  @override
  void initState() {
    super.initState();
    articulos = getArticlesData();
    dataArticulos = ArticlesDataSource(ArticlesData: articulos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kardex de inventario', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SfDataGrid(
        allowSorting: true,
        allowSwiping: true,
        onCellDoubleTap: (details) => 
          Navigator.pushNamed(context, 'articles'),
        source: dataArticulos,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: const Text('ID'),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Name'),
            ),
          ),
          GridColumn(
            columnName: 'designation',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Designation', overflow: TextOverflow.ellipsis),
            ),
          ),
          GridColumn(
            columnName: 'salary',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Salary'),
            ),
          ),
        ],
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

List<Articles> getArticlesData() {
  return [
    Articles(10001, 'James', 'Project Lead', 20000),
    Articles(10002, 'Kathryn', 'Manager', 30000),
    Articles(10003, 'Lara', 'Developer', 15000),
    Articles(10004, 'Michael', 'Designer', 15000),
    Articles(10005, 'Martin', 'Developer', 15000),
    Articles(10006, 'Newberry', 'Developer', 15000),
    Articles(10007, 'Balnc', 'Developer', 15000),
    Articles(10008, 'Perry', 'Developer', 15000),
    Articles(10009, 'Gable', 'Developer', 15000),
    Articles(10010, 'Grimes', 'Developer', 15000)
  ];
}

class ArticlesDataSource extends DataGridSource {

  List<DataGridRow> _datosArticulos = [];

  ArticlesDataSource({required List<Articles> ArticlesData}) {

    _datosArticulos = 
              ArticlesData.map<DataGridRow>((dataGridRow) =>
              
               DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(columnName: 'salary', value: dataGridRow.salary),

            ]))
        .toList();
  }

  

  List<DataGridRow> get rows => _datosArticulos;

  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
