import 'package:flutter_modular/flutter_modular.dart';
import 'auth/presentation/auth_module.dart';
import 'home/presentation/home_module.dart';
import 'stock/presentation/stock_module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.module('/stock', module: StockModule());
  }
}
