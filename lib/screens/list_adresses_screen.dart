import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_e_ship/screens/edit_address_screen.dart';
import '../database.dart';
import 'add_address_screen.dart';

class ListAddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endereços'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, dbProvider, child) {
          return FutureBuilder<List<Address>>(
            future: dbProvider.fetchAddresses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final addresses = snapshot.data!;
                return ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    return ListTile(
                      title: Text('${address.street}, ${address.city}'),
                      subtitle: Text('${address.state}, ${address.zipCode}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          dbProvider.deleteAddress(address.id!);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditAddressScreen(address: address),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return Center(child: Text('Nenhum endereço encontrado'));
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAddressScreen()),
          );
        },
      ),
    );
  }
}
