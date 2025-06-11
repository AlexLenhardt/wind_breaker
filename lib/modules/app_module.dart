import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/modules/client/client_module.dart';
import 'auth/presentation/auth_module.dart';
import 'home/presentation/home_module.dart';
import 'stock/presentation/stock_module.dart';
import 'service_order/presentation/service_order_module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.module('/home/', module: HomeModule());
    r.module('/estoque/', module: StockModule());
    r.module('/os/', module: ServiceOrderModule());
    r.module('/cliente/', module: ClientModule());
  }
}
