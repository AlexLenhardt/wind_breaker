import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wind_breaker/modules/stock/domain/entities/stock_item.dart';
import 'package:wind_breaker/modules/stock/presentation/cubit/stock_state.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit() : super(StockInitial());

  List<StockItem> _items = [];

  void loadStock() {
    emit(StockLoading());

    // Simulando carregamento com 50 itens
    _items = List.generate(
      50,
      (index) => StockItem(
        code: 'code $index',
        id: 'ID $index',
        name: 'name $index',
        description: 'Descrição do item $index',
        timberCode: 'Timber $index',
        quantity: index * 5,
      ),
    );

    emit(StockLoaded(List.from(_items)));
  }

  void addItem(StockItem newItem) {
    _items.add(newItem);
    emit(StockLoaded(List.from(_items)));
  }

  void updateItem(StockItem updatedItem) {
    final index = _items.indexWhere((i) => i.code == updatedItem.code);
    if (index != -1) {
      _items[index] = updatedItem;
      emit(StockLoaded(List.from(_items)));
    }
  }
}
