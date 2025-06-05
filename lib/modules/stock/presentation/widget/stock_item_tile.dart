import 'package:flutter/material.dart';
import '../../domain/entities/stock_item.dart';

class StockItemTile extends StatelessWidget {
  final StockItem item;

  const StockItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('Código: ${item.code} | Timber: ${item.timberCode}'),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Qtd: ${item.quantity}'),
          TextButton(
            onPressed: () {
              // abrir detalhes
            },
            child: const Text('Ver mais'),
          ),
        ],
      ),
    );
  }
}
