import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/customer.dart';

abstract class CustomerRepository {
  Future<void> createCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(Customer customer);
  Future<Customer> getCustomer(int id);
  Future<List<Customer>> getAllCustomers();
}

class CustomerDatabaseRepository implements CustomerRepository {
  static Database? _database;
  static const _dbName = 'myDatabase.db';
  static const _dbVersion = 1;
  static const table = 'customers';

  static const columnId = 'id';
  static const columnFirstName = 'first_name';
  static const columnLastName = 'last_name';
  static const columnDateOfBirth = 'date_of_birth';
  static const columnPhoneNumber = 'phone_number';
  static const columnEmail = 'email';
  static const columnBankAccountNumber = 'bank_account_number';

  static final CustomerDatabaseRepository _instance = CustomerDatabaseRepository._internal();

  factory CustomerDatabaseRepository() => _instance;

  CustomerDatabaseRepository._internal();

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);

  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnFirstName TEXT NOT NULL,
        $columnLastName TEXT NOT NULL,
        $columnDateOfBirth TEXT NOT NULL,
        $columnPhoneNumber TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnBankAccountNumber TEXT NOT NULL
      )
    ''');
  }

  @override
  Future<void> createCustomer(Customer customer) async {
    final db = await database;
    await db.insert(table, customer.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    final db = await database;

    await db.update(table, customer.toMap(),
        where: '$columnId = ?', whereArgs: [customer.email]);
  }

  @override
  Future<void> deleteCustomer(Customer customer) async {
    final db = await database;

    await db.delete(table, where: '$columnId = ?', whereArgs: [customer.email]);
  }

  @override
  Future<Customer> getCustomer(int id) async {
    final db = await database;

    final maps = await db.query(table,
        columns: [columnId, columnFirstName, columnLastName, columnDateOfBirth, columnPhoneNumber, columnEmail, columnBankAccountNumber],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Customer.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  @override
  Future<List<Customer>> getAllCustomers() async {
    final db = await database;

    final result = await db.query(table);
    // print(result);
    return result.map((json) => Customer.fromMap(json)).toList();
  }

}