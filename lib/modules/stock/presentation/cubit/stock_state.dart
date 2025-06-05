import '../../domain/entities/stock_item.dart';

abstract class StockState {}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<StockItem> items;

  StockLoaded(this.items);
}

class StockError extends StockState {
  final String message;

  StockError(this.message);
}
