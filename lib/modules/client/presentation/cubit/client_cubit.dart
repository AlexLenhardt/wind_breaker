import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wind_breaker/modules/client/domain/entities/client.dart';
import 'package:wind_breaker/modules/client/presentation/cubit/client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit() : super(ClientInitial());

  List<Client> _items = [];

  void loadClient() {
    emit(ClientLoading());

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

    emit(ClientLoaded(List.from(_items)));
  }

  void addItem(Client newItem) {
    _items.add(newItem);
    emit(ClientLoaded(List.from(_items)));
  }

  void updateItem(Client updatedItem) {
    final index = _items.indexWhere((i) => i.uuid == updatedItem.uuid);
    if (index != -1) {
      _items[index] = updatedItem;
      emit(ClientLoaded(List.from(_items)));
    }
  }
}
