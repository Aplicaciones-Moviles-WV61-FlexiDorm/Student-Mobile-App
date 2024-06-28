import 'package:latlong2/latlong.dart';

class MapMarker {

  final String image;
  final String title;
  final String address;
  final LatLng location;

  const MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location
  });
}

final _locations = [
  const LatLng(-12.0080041, -77.0778237),
  const LatLng(-12.0430962, -77.0208307),
  const LatLng(-12.0480045, -77.0205112),
  const LatLng(-12.0654067, -77.0257675),
  const LatLng(-12.0238438, -77.0822122),
];

const _path = "aasets/animated_markers_map/";

final mapMarkers = [
  MapMarker(
    image: "${_path}marker_1.png",
    title: "Habitacion 1",
    address: "Miraflores, Lima",
    location: _locations[0],
  ),
  MapMarker(
    image: "${_path}marker_2.png",
    title: "Habitacion 2",
    address: "Surco, Lima",
    location: _locations[1],
  ),
  MapMarker(
    image: "${_path}marker_3.png",
    title: "Habitacion 3",
    address: "San Isidro, Lima",
    location: _locations[2],
  ),
  MapMarker(
    image: "${_path}marker_4.png",
    title: "Habitacion 4",
    address: "Villa EL Salvador, Lima",
    location: _locations[3],
  ),
];