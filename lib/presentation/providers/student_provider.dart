import 'dart:convert';
import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends ChangeNotifier  {
  Student? _student;

  Student? get student => _student;

  Future<void> loadStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? studentJson = preferences.getString("student");
    if (studentJson != null) {
      _student = Student.fromJson(jsonDecode(studentJson));
      notifyListeners();
    }
  }

  Future<void> saveStudent(Student student) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("student", jsonEncode(student.toJson()));
    _student = student;
    notifyListeners();
  }

  Future<void> clearStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("student");
    _student = null;
    notifyListeners();
  }

}