import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: Drawer(
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
      ),
      body:
          const RouterOutlet(), // Aqui será carregado o conteúdo do módulo selecionado
    );
  }
}
