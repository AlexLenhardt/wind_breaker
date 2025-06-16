import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';

Widget formField(
  String label,
  TextEditingController controller, {
  bool isNumeric = false,
  bool isEditable = true,
  bool isDocument = false,
  bool isRequired = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      readOnly: !isEditable,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: isDocument
          ? [FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()]
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if ((value?.trim().isEmpty ?? true && isRequired)) {
          return 'Preencha o campo "$label"';
        }
        if (isDocument && !UtilBrasilFields.isCPFValido(value?.trim() ?? '')) {
          return 'Insira um CPF válido.';
        }
        return null;
      },
    ),
  );
}

Widget formTextArea(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

Widget formFieldDateTime({
  required String label,
  required DateTime? selectedTime,
  required void Function(DateTime?) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DateTimeField(
      value: selectedTime,
      dateFormat: DateFormat("dd/MM/yyyy HH:mm", "pt_BR"),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

Widget formFieldSelectorStatus({
  required int currentValue,
  required void Function(int?) onChanged,
}) {
  final Map<String, int> statusMap = {'Ativo': 0, 'Inativo': 1};

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: DropdownButtonFormField<int>(
      value: currentValue,
      decoration: const InputDecoration(
        hintText: 'Status',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
      items: statusMap.entries.map((entry) {
        return DropdownMenuItem<int>(
          value: entry.value,
          child: Text(entry.key),
        );
      }).toList(),
    ),
  );
}
