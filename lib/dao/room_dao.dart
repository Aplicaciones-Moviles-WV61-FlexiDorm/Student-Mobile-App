
import 'package:flexidorm_student_app/database/app_database.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:sqflite/sqflite.dart';

class RoomDao{
  insert(Room room) async {
    Database db = await AppDatabase.openDB();
    await db.insert(AppDatabase.tableName, room.toMap());
  }

  delete(Room room) async{
    Database db = await AppDatabase.openDB();
    await db.delete(
      AppDatabase.tableName, 
      where: "roomId = ?", 
      whereArgs: [room.roomId]
    );
  }

  Future<bool> isFavorite (Room room) async {
    Database db = await AppDatabase.openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.tableName, 
      where: "roomId = ?", 
      whereArgs: [room.roomId]
    );

    return maps.isNotEmpty;
  }

  Future<List<Room>> fetchFavorites () async {
    Database db = await AppDatabase.openDB();
    final List<Map<String, dynamic>> maps = await db.query(AppDatabase.tableName);
    return maps.map((map) => Room.fromMap(map)).toList();
  }

}