// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/modules/stock/domain/entities/stock_item.dart';
import 'package:wind_breaker/modules/stock/presentation/cubit/stock_cubit.dart';

class StockItemModal extends StatefulWidget {
  final StockItem? item;

  const StockItemModal({super.key, this.item});

  @override
  State<StockItemModal> createState() => _StockItemModalState();
}

class _StockItemModalState extends State<StockItemModal>
    with SingleTickerProviderStateMixin {
  late final TextEditingController codeController;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController timberCodeController;
  late final TextEditingController quantityController;

  late final bool isNew;
  late final TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    isNew = widget.item == null;

    final item = widget.item;
    codeController = TextEditingController(text: item?.code ?? '');
    nameController = TextEditingController(text: item?.name ?? '');
    descriptionController = TextEditingController(
      text: item?.description ?? '',
    );
    timberCodeController = TextEditingController(text: item?.timberCode ?? '');
    quantityController = TextEditingController(
      text: item?.quantity.toString() ?? '',
    );

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    timberCodeController.dispose();
    quantityController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newItem = StockItem(
        code: codeController.text.trim(),
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        timberCode: timberCodeController.text.trim(),
        quantity: int.tryParse(quantityController.text.trim()),
      );

      final cubit = Modular.get<StockCubit>();

      if (isNew) {
        cubit.addItem(newItem);
      } else {
        cubit.updateItem(newItem);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Informações'),
                Tab(text: 'Ordens de Serviço'),
              ],
            ),
            Container(
              height: 410,
              padding: const EdgeInsets.all(16),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildInfoTab(),
                  const Center(child: Text('Ordens de Serviço (em breve)')),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(isNew ? 'Cadastrar' : 'Salvar'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16),
            _formField('Código', codeController),
            _formField('Nome', nameController),
            _formField('Descrição', descriptionController),
            _formField('Código Timber', timberCodeController),
            _formField(
              'Quantidade em Estoque',
              quantityController,
              isNumeric: true,
              isEditable: isNew ?? true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _formField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
    bool isEditable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: !isEditable,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if ((value?.trim().isEmpty ?? true)) {
            return 'Preencha o campo "$label"';
          }
          return null;
        },
      ),
    );
  }
}
