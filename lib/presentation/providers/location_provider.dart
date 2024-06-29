
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier{

  bool _isLocationEnabled = false;
  Position? _currentPosition;

  bool get isLocationEnabled => _isLocationEnabled;
  Position? get currentPosition => _currentPosition;

  void setLocationEnabled(bool isEnabled) {
    _isLocationEnabled = isEnabled;
    notifyListeners();
  }

  void setCurrentPosition(Position? position) {
    _currentPosition = position;
    notifyListeners();
  }
}