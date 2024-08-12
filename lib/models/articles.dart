
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Articles {
  Articles(this.id, this.descripcion, this.precio, this.existencia);

  final int id;
  final String descripcion;
  final int precio;
  final int existencia;
}


class ArticulosFuente extends DataGridSource {
  List<DataGridRow> dataGridRows = [];

  ArticulosFuente({required List<Articles> dataArticulos}) {
    updateData(dataArticulos);
  }

  void updateData(List<Articles> articlesData) {
    dataGridRows = articlesData.map<DataGridRow>((article) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: article.id),
      DataGridCell<String>(columnName: 'descripcion', value: article.descripcion),
      DataGridCell<int>(columnName: 'precio', value: article.precio),
      DataGridCell<int>(columnName: 'existencia', value: article.existencia),
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


