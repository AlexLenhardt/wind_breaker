import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wind_breaker/modules/stock/domain/entities/stock_item.dart';
import 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  StockCubit() : super(StockInitial());

  void loadStock() {
    emit(StockLoading());
    log("passou aqui");
    Future.delayed(const Duration(seconds: 1), () {
      final items = List.generate(50, (index) {
        return StockItem(
          id: (index + 1).toString().padLeft(3, '0'),
          name: 'Item ${index + 1}',
          code: 'Code ${index + 1}',
          description: 'Descrição do item número ${index + 1}',
          timberCode: 'TMB${(index + 1).toString().padLeft(3, '0')}',
          quantity: (index + 1) * 3,
        );
      });

      emit(StockLoaded(items));
    });
  }
}
