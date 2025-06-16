import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerField extends StatefulWidget {
  final String label;
  final void Function(DateTime dateTime)? onChanged;

  const DateTimePickerField({super.key, required this.label, this.onChanged});

  @override
  State<DateTimePickerField> createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {
  DateTime? selectedDateTime;
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
      );

      if (time != null) {
        final DateTime dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        setState(() {
          selectedDateTime = dateTime;
          _controller.text = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
        });

        if (widget.onChanged != null) {
          widget.onChanged!(dateTime);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
      onTap: () => _selectDateTime(context),
    );
  }
}
