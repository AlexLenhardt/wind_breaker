import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/modules/client/presentation/cubit/client_cubit.dart';
import 'package:wind_breaker/modules/client/presentation/pages/client_page_list.dart';

class ClientModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ClientCubit>(ClientCubit.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const ClientPageList());
  }
}
