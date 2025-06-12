import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wind_breaker/core/widget/form_fields.dart';
import 'package:wind_breaker/modules/client/domain/entities/client.dart';
import 'package:wind_breaker/modules/client/presentation/cubit/client_cubit.dart';

class ClientModal extends StatefulWidget {
  final Client? item;

  const ClientModal({super.key, this.item});

  @override
  State<ClientModal> createState() => _ClientModalState();
}

class _ClientModalState extends State<ClientModal>
    with SingleTickerProviderStateMixin {
  late final TextEditingController nameController;
  late final TextEditingController documentController;
  late final TextEditingController statusController;

  late final bool isNew;
  late final TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    isNew = widget.item == null;

    final item = widget.item;
    nameController = TextEditingController(text: item?.name ?? '');
    documentController = TextEditingController(text: item?.document ?? '');
    statusController = TextEditingController(
      text: item?.statusCode.toString().trim() ?? '0',
    );

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    nameController.dispose();
    documentController.dispose();
    statusController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newItem = Client(
        name: nameController.text.trim(),
        document: documentController.text.trim(),
        statusCode: int.tryParse(statusController.text.trim()),
      );

      final cubit = Modular.get<ClientCubit>();

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
            formField('Nome', nameController),
            formField('CPF', documentController, isDocument: true),
            formFieldSelectorStatus(
              currentValue: int.tryParse(statusController.text) ?? 0,
              onChanged: (newValue) {
                setState(() {
                  statusController.text = newValue.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
