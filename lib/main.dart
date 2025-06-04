import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './modules/app_module.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Brava Tech',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}

Drawer DrawerDefault() {
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
            Modular.to.navigate('/stock/');
          },
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Recursos Humanos'),
          onTap: () {
            Modular.to.navigate('/rh/');
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
