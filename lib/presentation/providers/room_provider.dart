import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomProvider extends ChangeNotifier {
  final String baseUrl = "https://flexidorms-api-mov-8stmr.ondigitalocean.app/api/v1/";

  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  Future<void> fetchRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");

    int roomId = 32; // debe empezar desde el ID 12
    bool fetchMore = true;

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    while (fetchMore) {
      final url = "${baseUrl}room/getRoomsByRoomId/$roomId";
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
              _rooms.add(Room.fromJson(data));
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
    notifyListeners();
  }
}