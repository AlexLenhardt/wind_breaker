import 'package:flutter_modular/flutter_modular.dart';
import 'pages/initial_page.dart';

class AuthModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (_) => const InitialPage());
  }
}
