import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';

class RoomProvider extends ChangeNotifier {
  final List<Room> _rooms = [];

  List<Room> get rooms => _rooms;

  Future<void> loadRooms() async {
    final rooms = await StudentService().getRooms();
    _rooms.addAll(rooms);
    notifyListeners();
  }

  /*
    Future<void> loadMoreRooms() async {
      final nextRoomId = _rooms.last.roomId + 1;
      final moreRooms = await StudentService().getRooms(roomId: nextRoomId);
      _rooms.addAll(moreRooms);
      notifyListeners();
    }
  */
} 