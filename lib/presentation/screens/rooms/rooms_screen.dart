import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/presentation/providers/location_provider.dart';
import 'package:flexidorm_student_app/presentation/providers/room_provider.dart';
import 'package:flexidorm_student_app/presentation/providers/student_provider.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  List<Room> _filteredRooms = [];


  @override
  void initState() {
    super.initState();
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    roomProvider.fetchRooms();
  }

  void _searchRooms(String query) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    setState(() {
      _filteredRooms = roomProvider.rooms.where((room) {
      return room.title.toLowerCase().contains(query.toLowerCase()) ||
          room.description.toLowerCase().contains(query.toLowerCase()) ||
          room.address.toLowerCase().contains(query.toLowerCase()) || 
          room.price.toString().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final student = studentProvider.student;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _ProfileImage(urlImage: student!.profilePicture),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  _Welcome(studentName: "${student.firstName} ${student.lastName}"),
                  const SizedBox(height: 20),
                  _SearchRoomsButton(onSearch: _searchRooms),
                  const SizedBox(height: 20),
                  _CarouselRooms(),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomElevatedButton(
                        text: "Ver habitaciones reservadas",
                        backgroundColor: const Color.fromARGB(255, 138, 93, 229),
                        onPressed: () => context.go("/reservations"),
                        widthButton: 200,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Consumer<RoomProvider>(
                    builder: (context, roomProvider, child) {
                      if (roomProvider.rooms.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Column(
                          children: _filteredRooms.isNotEmpty
                            ? _filteredRooms.map((room) => RoomCard(room: room)).toList()
                            : roomProvider.rooms.map((room) => RoomCard(room: room)).toList()
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileImage extends StatefulWidget {
  final String urlImage;

  const _ProfileImage({
    required this.urlImage
  });

  @override
  State<_ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<_ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        widget.urlImage        
      ),
    );
  }
}

class _Welcome extends StatefulWidget {
  final String studentName;

  const _Welcome({
    required this.studentName
  });

  @override
  State<_Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<_Welcome> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Hola! ${widget.studentName}",
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SearchRoomsButton extends StatefulWidget {
  final Function(String) onSearch;

  const _SearchRoomsButton({required this.onSearch});

  @override
  State<_SearchRoomsButton> createState() => _SearchRoomsButtonState();
}

class _SearchRoomsButtonState extends State<_SearchRoomsButton> {
  final TextEditingController _controller = TextEditingController();
  String _search = "";

  @override
  Widget build(BuildContext context) {
  
    return TextField(
      controller: _controller,
      decoration:  const InputDecoration(
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 117, 52, 246),
            style: BorderStyle.solid
          ),
        ),
        hintText: "Buscar habitaciones",
      ),
      onChanged: (value) {
        setState(() {
          _search = value;
        });
        widget.onSearch(_search);
      }
    );
  }
}

/*Habitaciones que estan cerca de la ubicacion del estudiante*/
class _CarouselRooms extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context);

    if(locationProvider.currentPosition == null || roomProvider.rooms.isEmpty) {
      return const Center(
        child: Text("No se encontraron habitaciones cercanas"),
      );
    }

    List<RoomWithDistance> roomsWithDistance = [];

    double _toRadians(double deg) {
      return deg * pi / 180;
    }

    //Calcular la distancia entre la ubicación del estudiante y la ubicación de cada habitación
    double _calculateDistance(double latitude1, double longitude1, double latitude2, double longitude2) {
    const R = 6371; // Radius of the earth in km
    double dLat = _toRadians(latitude2 - latitude1);
    double dLon = _toRadians(longitude2 - longitude1);
    double lat1Rad = _toRadians(latitude1);
    double lat2Rad = _toRadians(latitude2);

    double a = sin(dLat / 2) * sin(dLat / 2) + sin(dLon / 2) * sin(dLon / 2) * cos(lat1Rad) * cos(lat2Rad);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c;

    return distance;
  }

    
    roomProvider.rooms.forEach((room) {
      double distance = _calculateDistance(
        locationProvider.currentPosition!.latitude,
        locationProvider.currentPosition!.longitude,
        room.latitude,
        room.longitude
      );

      RoomWithDistance roomWithDistance = RoomWithDistance(
        roomId: room.roomId,
        title: room.title,
        description: room.description,
        address: room.address,
        imageUrl: room.imageUrl,
        price: room.price,
        nearUniversities: room.nearUniversities,
        latitude: room.latitude,
        longitude: room.longitude,
        arrenderId: room.arrenderId,
        distance: distance
      );

      roomsWithDistance.add(roomWithDistance);
    });

    roomsWithDistance.sort((a, b) => a.distance.compareTo(b.distance));

    return CarouselSlider(
      options: CarouselOptions(
        height: 190.0,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        viewportFraction: 0.6,
      ),
      items: roomsWithDistance.take(5).map((room) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: NetworkImage(room.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const  EdgeInsets.all(10.0),
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5.0),
                        Text(
                          room.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              room.address,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/room-details", extra: room);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: room.imageUrl,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      room.address,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "S/.${room.price.toStringAsFixed(2)} por hora",
                      style: const TextStyle(
                        fontSize: 14,
                        color:Color.fromARGB(255, 75, 22, 182),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
