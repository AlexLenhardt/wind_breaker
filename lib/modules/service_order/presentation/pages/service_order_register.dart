// ignore_for_file: file_names

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wind_breaker/core/widget/form_buttons.dart';
import 'package:wind_breaker/core/widget/form_fields.dart';
import 'package:wind_breaker/main.dart';
import 'package:wind_breaker/modules/service_order/presentation/widgets/date_time_picker_widget.dart';
import 'package:wind_breaker/modules/stock/domain/entities/stock_item.dart';

class ServiceOrderRegister extends StatefulWidget {
  final StockItem? item;

  const ServiceOrderRegister({super.key, this.item});

  @override
  State<ServiceOrderRegister> createState() => _ServiceOrderRegisterState();
}

class _ServiceOrderRegisterState extends State<ServiceOrderRegister> {
  late final TextEditingController equipamentController;
  late final TextEditingController chassiController;
  late final TextEditingController clientController;
  final TextEditingController dateController = TextEditingController();

  late final DateTime dateTimeStart;
  late final DateTime? dateTimeEnd;
  late final TextEditingController descriptionController;
  late final TextEditingController hourSpentController;

  @override
  void initState() {
    super.initState();

    equipamentController = TextEditingController(text: "");
    chassiController = TextEditingController(text: "");
    clientController = TextEditingController(text: "");
    descriptionController = TextEditingController(text: "");
    hourSpentController = TextEditingController(text: "");
    dateTimeStart = DateTime.now();
    dateTimeEnd = null;
  }

  @override
  void dispose() {
    super.dispose();
    equipamentController.dispose();
    chassiController.dispose();
    clientController.dispose();
    descriptionController.dispose();
    hourSpentController.dispose();
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
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(70, 108, 108, 108),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              padding: EdgeInsets.all(50),
              child: Column(
                spacing: 6,
                children: [
                  formField("Equipamento", equipamentController),
                  formField("Chassi", chassiController),
                  formField("Cliente", clientController),

                  DateTimePickerField(
                    onChanged: (dateTime) {},
                    label: 'Data/hora inicio',
                  ),
                  DateTimePickerField(
                    onChanged: (dateTime) {},
                    label: 'Data/hora fim',
                  ),

                  formField("Horas gastas", hourSpentController),
                  formTextArea("Descrição", descriptionController),
                  formButton(
                    () => AlertDialog(backgroundColor: Colors.amber),
                    "Cadastrar",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showDatePicker() async => await showDatePickerDialog(
    context: context,

    initialDate: DateTime.now(),
    minDate: DateTime(2020, 10, 10),
    maxDate: DateTime(2024, 10, 30),
    width: 300,
    height: 300,
    currentDate: DateTime(2022, 10, 15),
    selectedDate: DateTime(2022, 10, 16),
    currentDateDecoration: const BoxDecoration(),
    currentDateTextStyle: const TextStyle(),
    daysOfTheWeekTextStyle: const TextStyle(),
    disabledCellsTextStyle: const TextStyle(),
    enabledCellsDecoration: const BoxDecoration(),
    enabledCellsTextStyle: const TextStyle(),
    initialPickerType: PickerType.days,
    selectedCellDecoration: const BoxDecoration(),
    selectedCellTextStyle: const TextStyle(),
    leadingDateTextStyle: const TextStyle(),
    slidersColor: Colors.lightBlue,
    highlightColor: Colors.redAccent,
    slidersSize: 20,
    splashColor: Colors.lightBlueAccent,
    splashRadius: 40,
    centerLeadingDate: true,
  );
}
