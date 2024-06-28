import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class AppDatabase{
  static int version = 1;
  static String databaseName = "room.db";
  static String tableName = "rooms";
  static Database? _db;

  static Future<Database> openDB() async {
    _db ??= await openDatabase(
        join(
          await getDatabasesPath(), 
          databaseName
        ),
        version: version,
        onCreate: (db, version) {
          String query = 
          """
          CREATE TABLE $tableName(
            roomId INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            address TEXT,
            latitude DOUBLE,
            longitude DOUBLE,
            price DOUBLE,
            nearUniversities TEXT, 
            arrenderId INTEGER,
            imageUrl TEXT
          )
          """;
          db.execute(query);
        },
      );

    return _db as Database;
  }
}