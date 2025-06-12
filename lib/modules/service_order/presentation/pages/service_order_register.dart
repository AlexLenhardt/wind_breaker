// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wind_breaker/core/widget/form_buttons.dart';
import 'package:wind_breaker/core/widget/form_fields.dart';
import 'package:wind_breaker/main.dart';
import 'package:wind_breaker/modules/stock/domain/entities/stock_item.dart';

class ServiceOrderRegister extends StatefulWidget {
  final StockItem? item;

  const ServiceOrderRegister({super.key, this.item});

  @override
  State<ServiceOrderRegister> createState() => _ServiceOrderRegisterState();
}

class _ServiceOrderRegisterState extends State<ServiceOrderRegister> {
  late final TextEditingController testController1;
  late final TextEditingController testController2;
  late final TextEditingController testController3;

  @override
  void initState() {
    super.initState();
    testController1 = TextEditingController(text: "1");
    testController2 = TextEditingController(text: "2");
    testController3 = TextEditingController(text: "3");
  }

  @override
  void dispose() {
    testController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar OS')),
      drawer: drawerDefault(),
      body: Padding(
        padding: EdgeInsetsGeometry.directional(
          bottom: 16,
          end: 100,
          start: 100,
          top: 16,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(70, 108, 108, 108),
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          padding: EdgeInsets.all(50),
          child: Column(
            spacing: 6,
            children: [
              formField("teste1", testController1),
              formField("teste2", testController2),
              formField("teste3", testController3),
              formButton(
                () => testController1.value = TextEditingValue(text: "eba"),
                "Cadastrar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
