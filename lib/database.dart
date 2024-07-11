import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class Address {
  final int? id;
  final String street;
  final String city;
  final String state;
  final String zipCode;

  Address({
    this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int?,
      street: map['street'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      zipCode: map['zipCode'] as String,
    );
  }
}

class DatabaseProvider extends ChangeNotifier {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('addresses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    String path = join(await getDatabasesPath(), filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE addresses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        street TEXT,
        city TEXT,
        state TEXT,
        zipCode TEXT
      )
    ''');
  }

  Future<void> insertAddress(Address address) async {
    final db = await database;
    await db.insert(
      'addresses',
      address.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<Address>> fetchAddresses() async {
    final db = await database;
    final maps = await db.query('addresses');
    return List.generate(maps.length, (i) {
      return Address.fromMap(maps[i]);
    });
  }

  Future<void> updateAddress(Address address) async {
    final db = await database;
    await db.update(
      'addresses',
      address.toMap(),
      where: 'id = ?',
      whereArgs: [address.id],
    );
    notifyListeners();
  }

  Future<void> deleteAddress(int id) async {
    final db = await database;
    await db.delete(
      'addresses',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }
}
