import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wind_breaker/modules/service_order/domain/entities/service_order_entities.dart';
import 'package:wind_breaker/modules/service_order/presentation/cubit/service_order_state.dart';

class ServiceOrderCubit extends Cubit<ServiceOrderState> {
  ServiceOrderCubit() : super(ServiceOrderInitial());

  List<ServiceOrder> _items = [];

  void loadServiceOrder() {
    emit(ServiceOrderLoading());

    // Simulando carregamento com 50 itens
    // _items = List.generate(
    //   50,
    //   (index) => StockItem(
    //     code: 'JQBDJKQWNDKJQWNDKQJWN QW JBDJQWH BDJQWHB DHJWQ D $index',
    //     id: 'QKWJNDQWJKDN KQWJND KJQWND KJQWNJDK QNWJKD QW $index',
    //     name: 'QKDQWNKJ DNQWJKDN QWJKND KQWJNDQWJN QW $index',
    //     description:
    //         'QDMKN QWJDN QWJKDN QWJKND KJQWND JQWND JQNWK DNQWJKN DQWJKND JKQWN JKDNQWJ DNQWKDN KJQWN  $index',
    //     timberCode:
    //         'D QWJBJK QWNDJK QWNDJK QWNJKD NQWJKDN QWKJDN QWJKN DKQWND KJQWN $index',
    //     quantity: index * 5,
    //   ),
    // );

    emit(ServiceOrderLoaded(List.from(_items)));
  }

  void addItem(ServiceOrder newItem) {
    _items.add(newItem);
    emit(ServiceOrderLoaded(List.from(_items)));
  }

  void updateItem(ServiceOrder updatedItem) {
    final index = _items.indexWhere((i) => i.uuid == updatedItem.uuid);
    if (index != -1) {
      _items[index] = updatedItem;
      emit(ServiceOrderLoaded(List.from(_items)));
    }
  }
}
