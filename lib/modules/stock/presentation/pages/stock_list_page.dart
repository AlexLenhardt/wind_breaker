import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../cubit/stock_cubit.dart';
import '../cubit/stock_state.dart';
import '../../domain/entities/stock_item.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  late final StockCubit cubit;

  String nameFilter = '';
  String codeFilter = '';
  String timberFilter = '';

  @override
  void initState() {
    super.initState();
    cubit = Modular.get<StockCubit>();
    cubit.loadStock();
  }

  List<StockItem> applyFilters(List<StockItem> items) {
    return items.where((item) {
      final matchesName =
          nameFilter.isEmpty ||
          item.name.toLowerCase().contains(nameFilter.toLowerCase());
      final matchesCode =
          codeFilter.isEmpty ||
          item.code.toLowerCase().contains(codeFilter.toLowerCase());
      final matchesTimber =
          timberFilter.isEmpty ||
          item.timberCode.toLowerCase().contains(timberFilter.toLowerCase());

      return matchesName && matchesCode && matchesTimber;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estoque')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Filtros
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por nome',
                    ),
                    onChanged: (v) =>
                        setState(() => nameFilter = v.toLowerCase()),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por código',
                    ),
                    onChanged: (v) =>
                        setState(() => codeFilter = v.toLowerCase()),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por Timber',
                    ),
                    onChanged: (v) =>
                        setState(() => timberFilter = v.toLowerCase()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tabela
            Expanded(
              child: BlocBuilder<StockCubit, StockState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is StockLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StockLoaded) {
                    final filteredItems = applyFilters(state.items);

                    return SingleChildScrollView(
                      child: PaginatedDataTable(
                        header: const Text('Itens em Estoque'),
                        columnSpacing: 200,
                        rowsPerPage: 10,
                        columns: const [
                          DataColumn(label: Text('Código')),
                          DataColumn(label: Text('Nome')),
                          DataColumn(label: Text('Descrição')),
                          DataColumn(label: Text('Timber')),
                          DataColumn(label: Text('Qtd')),
                          DataColumn(label: Text('Ações')),
                        ],
                        source: StockDataSource(filteredItems),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Nenhum item carregado.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // tela de cadastro
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

// Fonte da tabela
class StockDataSource extends DataTableSource {
  final List<StockItem> items;
  StockDataSource(this.items);

  @override
  DataRow getRow(int index) {
    final item = items[index];
    return DataRow(
      cells: [
        DataCell(Text(item.code)),
        DataCell(Text(item.name)),
        DataCell(Text(item.description)),
        DataCell(Text(item.timberCode)),
        DataCell(Text(item.quantity.toString())),
        DataCell(
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              // ação de visualizar
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
