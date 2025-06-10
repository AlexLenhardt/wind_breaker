import '../../domain/entities/service_order_entities.dart';

abstract class ServiceOrderState {}

class ServiceOrderInitial extends ServiceOrderState {}

class ServiceOrderLoading extends ServiceOrderState {}

class ServiceOrderLoaded extends ServiceOrderState {
  final List<ServiceOrder> items;

  ServiceOrderLoaded(this.items);
}

class StockError extends ServiceOrderState {
  final String message;

  StockError(this.message);
}
