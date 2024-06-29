import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/presentation/screens/maps/selected_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

const mapboxAccessToken = "pk.eyJ1IjoiamVzaHVzYXJ1dG9iaSIsImEiOiJjbHh5bnNpbWgwMnA2Mm1xNmpwanJhc2d5In0.0A8k1ww_i7-ggN5rpHz7Sg";
const markerColor = Color.fromARGB(255, 169, 63, 211);
const markerSizeExpanded = 55.0;
const markerSizeShrinked = 38.0;


class AnimatedMarkersMap extends StatefulWidget {
  final Room selectedRoom;
  final List<Room> rooms;

  AnimatedMarkersMap({
    super.key, 
    required this.selectedRoom, 
    required this.rooms
  });

  @override
  State<AnimatedMarkersMap> createState() => _AnimatedMarkersMapState();
}

class _AnimatedMarkersMapState extends State<AnimatedMarkersMap> with SingleTickerProviderStateMixin{
  final _pageController = PageController();
  int _selectedIndex = 0;
  late final AnimationController _animationController;

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];

    for(int i = 0; i < widget.rooms.length; i++) {
      final room = widget.rooms[i];

      _markerList.add(
        Marker(
          width: _selectedIndex == i ? markerSizeExpanded : markerSizeShrinked,
          height: _selectedIndex == i ? markerSizeExpanded : markerSizeShrinked,
          point: LatLng(room.latitude, room.longitude), 
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = i;
                _pageController.animateToPage(i, duration: const Duration(milliseconds: 500), curve: Curves.elasticOut);
                print("Selected: ${room.title}");
              });
            },
            child: _selectedIndex == i 
              ? SelectedMarker(animation: _animationController)
              : _LocationMarker(selected: _selectedIndex == i)
          )
        )
      );
    }
    return _markerList;
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.repeat(reverse: true);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadMap() async {
    final client = http.Client();
    const url = "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/14/4691/8749?access_token=$mapboxAccessToken";

    try {
      final response = await client.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        // Procesa la respuesta
      } else {
        print('Error al cargar el mapa: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al cargar el mapa: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Interactive Map"),
          actions: const [
            IconButton(
              onPressed: null, 
              icon: Icon(Icons.map_outlined),
            )
          ],
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(widget.selectedRoom.latitude,  widget.selectedRoom.longitude),
                initialZoom: 13,
                minZoom: 5,
                maxZoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                  additionalOptions: const {
                    "accessToken": mapboxAccessToken,
                    "id": "mapbox/streets-v11",
                  },
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              height: MediaQuery.of(context).size.height * 0.3,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.rooms.length, 
                itemBuilder: (context, index) {
                  final room = widget.rooms[index];
                  return _MapItemDetails(room: room);
                }
              ),
            ),
          ],
        ),
        
    );
  }
}

class _LocationMarker extends StatelessWidget {
  final bool selected;

  const _LocationMarker({
    //super.key, 
    this.selected = false
  });

  @override
  Widget build(BuildContext context) {
    final size = selected ? markerSizeExpanded : markerSizeShrinked;

    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.network("https://i.postimg.cc/ZKS5db4m/marker-purple.png",)
      ),
    );
  }
}


class _MapItemDetails extends StatelessWidget {
  final Room room;

  const _MapItemDetails({
    //super.key,
    required this.room
  });

  @override
  Widget build(BuildContext context) {

    final _styleTitle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold
    );

    final _styleAddress = TextStyle(
      color: Colors.grey[800],
      fontSize: 14
    );


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        room.imageUrl,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          room.title,
                          style: _styleTitle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          room.address,
                          style: _styleAddress,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Universidades cercanas:\n${room.nearUniversities}",
                          style: _styleAddress,
                        ),
                      ],
                    ) 
                  )
                ],
              ),
            ),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context.go("/reserve-rooms", extra: room);
              },
              color: markerColor,
              elevation: 6,
              child: const Text(
                "RESERVAR", 
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              )
            )
          ],
        ),
      ),
    );
  }
}