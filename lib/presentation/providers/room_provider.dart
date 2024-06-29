import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  Future<void> fetchRooms() async {
    final rooms = await StudentService().getRooms();
    _rooms = rooms;
    notifyListeners();
  }
}