import 'package:flexidorm_student_app/domain/models/reservation.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:flexidorm_student_app/presentation/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StudentService{
  final String baseUrl = "https://flexidorms-api-mov-8stmr.ondigitalocean.app/api/v1/";

  Future<ApiResponse> registerStudent(Student student) async {
    final url = "${baseUrl}auth/signUp/student";
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(student.toJson());

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200|| response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse.fromJson(jsonData);
    } else {
      throw Exception("Error al registrar estudiante");
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password, BuildContext context) async {
    final url = "${baseUrl}auth/signIn";
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final token = jsonData["data"]["token"];
      final student = Student.fromJson(jsonData["data"]);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("jwt_token", token);
      //await preferences.setString("student", jsonEncode(student.toJson()));
      final studentProvider = Provider.of<StudentProvider>(context, listen: false);
      await studentProvider.saveStudent(student);

      return jsonData;
      
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      return null;
    }
  }

  Future<List<Room>> getRooms() async {
    List<Room> rooms = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");

    int roomId = 32; // debe empezar desde el ID 12
    bool fetchMore = true;

    while (fetchMore) {
      final url = "${baseUrl}room/getRoomsByRoomId/$roomId";
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final roomData = jsonData["data"] as List<dynamic>;

        if (roomData.isEmpty) {
          fetchMore = false;
        } else {
          for (var data in roomData) {
            final roomImageUrl = data["imageUrl"];
            final imageUrlResponse = await http.head(Uri.parse(roomImageUrl));
            if (imageUrlResponse.statusCode == 200) {
              rooms.add(Room.fromJson(data));
            } else {
              print("Error al cargar la imagen: $roomImageUrl");
            }
          }
          roomId++;
        }
      } else {
        fetchMore = false;
      }
    }

    return rooms;
  }

  Future<bool> updateStudentProfile(Student student) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("jwt_token");

    if (student.studentId == null) {
      throw Exception("El ID del estudiante no puede ser nulo");
    }

    final url = "${baseUrl}auth/student/${student.studentId}";
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    final body = jsonEncode(student.toJson());

    final response = await http.put(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      await preferences.setString("student", jsonEncode(student.toJson()));
      return true;
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      return false;
    }
  }
  
  Future<bool> registerReservation(Map<String, dynamic> rental) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("jwt_token");
    
    final url = "${baseUrl}rental/registerRental";
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final body = jsonEncode(rental);
    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
      
    } else {
      return false;
    }
  }

  Future<List<Reservation>> getReservationsByStudent(String studentId) async {
    List<Reservation> reservations = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");

    final url = "${baseUrl}rental/search/$studentId";
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final reservationData = jsonData["data"] as List<dynamic>;

      for (var data in reservationData) {
        reservations.add(Reservation.fromJson(data));
      }
    }

    return reservations;
  }

  Future<Room> fetchRoom(int roomId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");

    final url = "${baseUrl}room/getRoomsByRoomId/$roomId";
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final roomData = jsonData["data"] as List<dynamic>;

      if (roomData.isNotEmpty) {
        final data = roomData[0];
        final roomImageUrl = data["imageUrl"];
        final imageUrlResponse = await http.head(Uri.parse(roomImageUrl));

        if (imageUrlResponse.statusCode == 200) {
          return Room.fromJson(data);
        } else {
          throw Exception("Error al cargar la imagen: $roomImageUrl");
        }
      } else {
        throw Exception("No se encontró la habitación con ID $roomId");
      }
    } else {
      throw Exception("Error al obtener la habitación");
    }
  }

}

class ApiResponse {
  final String message;
  final String status;
  final Student? data;

  ApiResponse({
    required this.message, 
    required this.status, 
    this.data
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"] != null ? Student.fromJson(json["data"]) : null,
    );
  }
}