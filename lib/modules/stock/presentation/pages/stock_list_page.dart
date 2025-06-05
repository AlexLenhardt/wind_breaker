import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/modules/stock/presentation/cubit/stock_cubit.dart';
import 'package:wind_breaker/modules/stock/presentation/cubit/stock_state.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  late final StockCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = Modular.get<StockCubit>();
    cubit.loadStock(); // carrega os dados ao abrir a página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estoque')),
      body: BlocBuilder<StockCubit, StockState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is StockLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StockLoaded) {
            final items = state.items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 2,
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      'Código: ${item.code} - Timber: ${item.timberCode}',
                    ),
                    trailing: Text('Qtd: ${item.quantity}'),
                    onTap: () {
                      // ação ao tocar
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Nenhum item carregado.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cubit.loadStock(); // recarrega os dados
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
