import 'package:flutter_modular/flutter_modular.dart';
import 'pages/stock_page.dart';

class StockModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (_) => StockPage());
  }
}
