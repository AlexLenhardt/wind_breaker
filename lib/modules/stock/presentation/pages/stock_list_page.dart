import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/main.dart';
import 'package:wind_breaker/modules/stock/presentation/widget/ItemDetailsDialog.dart';
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
      drawer: DrawerDefault(),
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
              child: Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                child: BlocBuilder<StockCubit, StockState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is StockLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is StockLoaded) {
                      final filteredItems = applyFilters(state.items);

                      return SingleChildScrollView(
                        controller: ScrollController(keepScrollOffset: true),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: PaginatedDataTable(
                            header: const Text('Itens em Estoque'),
                            rowsPerPage: 15,
                            columns: const [
                              DataColumn(label: Text('Código')),
                              DataColumn(label: Text('Nome')),
                              DataColumn(label: Text('Descrição')),
                              DataColumn(label: Text('Timber')),
                              DataColumn(label: Text('Qtd')),
                              DataColumn(label: Text('Ações')),
                            ],
                            source: StockDataSource(filteredItems, context),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Nenhum item carregado.'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => StockItemModal());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Fonte da tabela
class StockDataSource extends DataTableSource {
  final List<StockItem> items;
  final BuildContext context;

  StockDataSource(this.items, this.context);

  @override
  DataRow getRow(int index) {
    final item = items[index];
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 100,
            child: Text(item.code, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Text(item.name, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Text(item.description, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Text(item.timberCode, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(SizedBox(width: 100, child: Text(item.quantity.toString()))),
        DataCell(
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => StockItemModal(item: item),
              );
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
