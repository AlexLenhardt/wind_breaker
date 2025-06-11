import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/main.dart';
import 'package:wind_breaker/modules/service_order/domain/entities/service_order_entities.dart';
import 'package:wind_breaker/modules/service_order/presentation/cubit/service_order_cubit.dart';
import 'package:wind_breaker/modules/service_order/presentation/cubit/service_order_state.dart';

class ServiceOrderPage extends StatefulWidget {
  const ServiceOrderPage({super.key});

  @override
  State<ServiceOrderPage> createState() => _ServiceOrderListPageState();
}

class _ServiceOrderListPageState extends State<ServiceOrderPage> {
  late final ServiceOrderCubit cubit;

  String nameFilter = '';
  String codeFilter = '';
  String timberFilter = '';

  @override
  void initState() {
    super.initState();
    cubit = Modular.get<ServiceOrderCubit>();
    cubit.loadServiceOrder();
  }

  List<ServiceOrder> applyFilters(List<ServiceOrder> items) {
    return items.where((item) {
      final matchesTitle =
          nameFilter.isEmpty ||
          item.title.toLowerCase().contains(nameFilter.toLowerCase());
      // final matchesCode =
      //     codeFilter.isEmpty ||
      //     item.code.toLowerCase().contains(codeFilter.toLowerCase());
      // final matchesTimber =
      //     timberFilter.isEmpty ||
      //     item.timberCode.toLowerCase().contains(timberFilter.toLowerCase());

      return matchesTitle; //&& matchesCode && matchesTimber;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ordens de Serviço')),
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
                      labelText: 'Filtrar por título',
                    ),
                    onChanged: (v) =>
                        setState(() => nameFilter = v.toLowerCase()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tabela
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                child: BlocBuilder<ServiceOrderCubit, ServiceOrderState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is ServiceOrderLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ServiceOrderLoaded) {
                      final filteredItems = applyFilters(state.items);

                      return SingleChildScrollView(
                        controller: ScrollController(keepScrollOffset: true),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: PaginatedDataTable(
                            header: const Text('Ordens de Serviço'),
                            rowsPerPage: 15,
                            columns: const [
                              DataColumn(label: Text('Cliente')),
                              DataColumn(label: Text('Título')),
                              DataColumn(label: Text('Equipamento')),
                              DataColumn(label: Text('Status')),
                            ],
                            source: ServiceOrderDataSource(
                              filteredItems,
                              context,
                            ),
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
          // showDialog(context: context, builder: (_) => StockItemModal());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Fonte da tabela
class ServiceOrderDataSource extends DataTableSource {
  final List<ServiceOrder> items;
  final BuildContext context;

  ServiceOrderDataSource(this.items, this.context);
  // DataColumn(label: Text('Cliente')),
  // DataColumn(label: Text('Título')),
  // DataColumn(label: Text('Equipamento')),
  // DataColumn(label: Text('Status')),
  @override
  DataRow getRow(int index) {
    final item = items[index];
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 100,
            child: Text(item.client.name, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Text(item.title, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Text(item.item.name, overflow: TextOverflow.ellipsis),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Text(
              item.statusCode.toString(),
              overflow: TextOverflow.ellipsis,
            ),
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
