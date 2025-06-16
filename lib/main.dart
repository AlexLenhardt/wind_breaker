import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './modules/app_module.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Brava Tech',
      theme: ThemeData(primarySwatch: Colors.green),
      routerConfig: Modular.routerConfig,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'BR')],
    );
  }
}

Drawer drawerDefault() {
  return Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.lightGreen),
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.black, fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.warehouse),
          title: const Text('Estoque'),
          onTap: () {
            Modular.to.navigate('/estoque/');
          },
        ),
        ListTile(
          leading: const Icon(Icons.article),
          title: const Text('Ordem de Serviço'),
          onTap: () {
            Modular.to.navigate('/os/');
          },
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Cliente'),
          onTap: () {
            Modular.to.navigate('/cliente/');
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configurações'),
          onTap: () {
            Modular.to.navigate('/configuracoes/');
          },
        ),
      ],
    ),
  );
}
