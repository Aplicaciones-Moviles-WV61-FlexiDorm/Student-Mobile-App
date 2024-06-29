import 'package:flexidorm_student_app/presentation/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class SettingsScreen extends StatefulWidget {
  static const String name = "settings_screen";
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    } else if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _getCurrentLocation() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    try {
      Position position = await determinePosition();
      locationProvider.setCurrentPosition(position);
      print("Current Location: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      print("Error: $e");
    }
  }

  void _onLocationSwitchChanged(bool value) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.setLocationEnabled(value);

    if (value) {
      _getCurrentLocation();
    }
    else {
      locationProvider.setCurrentPosition(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/home");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Activar Ubicación",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: locationProvider.isLocationEnabled,
                  onChanged: _onLocationSwitchChanged,
                  activeColor: const Color.fromARGB(255, 117, 52, 246),
                ),
              ],
            ),
            if (locationProvider.currentPosition != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Ubicación Actual: ${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude}",
                ),
              ),
          ],
        ),
      ),
    );
  }
  
}