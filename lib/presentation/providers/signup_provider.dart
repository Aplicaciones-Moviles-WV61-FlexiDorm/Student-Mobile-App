import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier{
  String? userId;
  String? firstname;
  String? lastname;
  String? username;
  String? phoneNumber;
  String? email;
  String? password;
  String? address;
  String? birthDate;
  String? profilePicture;
  String? gender;
  String? university;

  void updateStudent(String key, dynamic value) {
    switch (key) {
      case 'userId':
        userId = value;
        break;
      case 'firstname':
        firstname = value;
        break;
      case 'lastname':
        lastname = value;
        break;
      case 'username':
        username = value;
        break;
      case 'phoneNumber':
        phoneNumber = value;
        break;
      case 'email':
        email = value;
        break;
      case 'password':
        password = value;
        break;
      case 'address':
        address = value;
        break;
      case 'birthDate':
        birthDate = value;
        break;
      case 'profilePicture':
        profilePicture = value;
        break;
      case 'gender':
        gender = value;
        break;
      case 'university':
        university = value;
        break;
    }
    notifyListeners();
  }
}