import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wind_breaker/modules/stock/domain/entities/stock_item.dart';

class ItemDetailsDialog extends StatelessWidget {
  final StockItem item;

  const ItemDetailsDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: DefaultTabController(
        length: 2,
        child: SizedBox(
          width: 600,
          height: 500,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Detalhes'),
                  Tab(text: 'OS Relacionadas'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Código: ${item.code}'),
                          Text('Nome: ${item.name}'),
                          Text('Descrição: ${item.description}'),
                          Text('Código Timber: ${item.timberCode}'),
                          Text('Quantidade: ${item.quantity}'),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 200,
                              height: 30,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.edit),
                                label: const Text('Editar'),
                                onPressed: () {
                                  log("hgi");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Center(child: Text('OS relacionadas (em breve)')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
