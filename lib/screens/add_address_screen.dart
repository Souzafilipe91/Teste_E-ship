import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_e_ship/database.dart';

class AddAddressScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Rua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a rua';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a cidade';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o estado';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(labelText: 'CEP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CEP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newAddress = Address(
                      street: _streetController.text,
                      city: _cityController.text,
                      state: _stateController.text,
                      zipCode: _zipCodeController.text,
                    );
                    final dbProvider = Provider.of<DatabaseProvider>(context, listen: false);
                    dbProvider.insertAddress(newAddress);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
