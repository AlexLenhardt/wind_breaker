import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/modules/stock/presentation/cubit/stock_cubit.dart';
import '../presentation/pages/stock_list_page.dart';

class StockModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<StockCubit>(StockCubit.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const StockListPage());
  }
}
