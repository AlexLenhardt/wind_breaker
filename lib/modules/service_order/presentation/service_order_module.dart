import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/modules/service_order/presentation/cubit/service_order_cubit.dart';
import 'package:wind_breaker/modules/service_order/presentation/pages/service_order_page.dart';

class ServiceOrderModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ServiceOrderCubit>(ServiceOrderCubit.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const ServiceOrderPage());
  }
}
