import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StudentService{
  final String baseUrl = "https://flexidormsapi-wfjf.onrender.com/api/v1/";

  Future<ApiResponse> registerStudent(Student student) async {
    final url = "${baseUrl}auth/signUp/student";
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(student.toJson());

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200|| response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse.fromJson(jsonData);
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      throw Exception("Error al registrar estudiante");
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = "${baseUrl}auth/signIn";
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      final token = jsonData["data"]["token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("jwt_token", token);
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

    int roomId = 12; // debe empezar desde el ID 12
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