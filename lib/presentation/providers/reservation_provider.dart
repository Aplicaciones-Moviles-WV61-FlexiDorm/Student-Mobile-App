import 'package:flexidorm_student_app/domain/models/reservation.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier{
  List<Reservation> _reservations = [];
  List<Reservation> get reservations => _reservations;

  Future<void> fetchReservations(String studentId) async  {
    _reservations = await StudentService().getReservationsByStudent(studentId);

    notifyListeners();
  }
}