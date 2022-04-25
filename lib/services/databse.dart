import '../models/user_model.dart';

class Database {
  static Database? _database;

  static Database get instance {
    _database;
    return _database!;
  }
}
