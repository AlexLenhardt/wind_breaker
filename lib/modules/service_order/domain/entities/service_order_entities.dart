import 'package:wind_breaker/modules/client/domain/entities/client.dart';
import 'package:wind_breaker/modules/stock/domain/entities/stock_item.dart';

class ServiceOrder {
  final String? uuid;
  final Client client;
  final StockItem item;
  final String chassi;
  final String description;
  final String title;
  final int statusCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceOrder({
    this.uuid,
    required this.client,
    required this.item,
    required this.chassi,
    required this.description,
    required this.title,
    required this.statusCode,
    required this.createdAt,
    required this.updatedAt,
  });
}
