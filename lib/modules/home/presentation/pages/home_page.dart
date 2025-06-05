import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: DrawerDefault(),
      body:
          const RouterOutlet(), // Aqui será carregado o conteúdo do módulo selecionado
    );
  }
}
