import 'package:flutter/material.dart';
import 'package:teste_e_ship/database.dart';
import 'package:teste_e_ship/models/address.dart';

class EditAddressScreen extends StatefulWidget {
  final Address address;

  EditAddressScreen({required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;

  @override
  void initState() {
    super.initState();
    _streetController = TextEditingController(text: widget.address.street);
    _cityController = TextEditingController(text: widget.address.city);
    _stateController = TextEditingController(text: widget.address.state);
    _zipCodeController = TextEditingController(text: widget.address.zipCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Rua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a rua';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Cidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a cidade';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'Estado'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o estado';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: InputDecoration(labelText: 'CEP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CEP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Address updatedAddress = Address(
                      id: widget.address.id,
                      street: _streetController.text,
                      city: _cityController.text,
                      state: _stateController.text,
                      zipCode: _zipCodeController.text,
                    );
                    await DatabaseProvider.db.updateAddress(updatedAddress);
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
