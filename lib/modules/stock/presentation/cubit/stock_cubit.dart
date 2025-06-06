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
        code: 'JQBDJKQWNDKJQWNDKQJWN QW JBDJQWH BDJQWHB DHJWQ D $index',
        id: 'QKWJNDQWJKDN KQWJND KJQWND KJQWNJDK QNWJKD QW $index',
        name: 'QKDQWNKJ DNQWJKDN QWJKND KQWJNDQWJN QW $index',
        description:
            'QDMKN QWJDN QWJKDN QWJKND KJQWND JQWND JQNWK DNQWJKN DQWJKND JKQWN JKDNQWJ DNQWKDN KJQWN  $index',
        timberCode:
            'D QWJBJK QWNDJK QWNDJK QWNJKD NQWJKDN QWKJDN QWJKN DKQWND KJQWN $index',
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
