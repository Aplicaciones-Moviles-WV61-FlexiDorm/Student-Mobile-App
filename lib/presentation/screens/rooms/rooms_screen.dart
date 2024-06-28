import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/presentation/providers/student_provider.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  late Future<List<Room>> _roomsFuture;


  @override
  void initState() {
    super.initState();
    _roomsFuture = StudentService().getRooms();
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
                  _SearchRoomsButton(),
                  const SizedBox(height: 20),
                  _CarouselRooms(),
                  const SizedBox(height: 20),

                  FutureBuilder<List<Room>>(
                    future: _roomsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();

                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');

                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No se encontraron habitaciones');

                      } else {
                        return Column(
                          children: snapshot.data!.map((room) => RoomCard(room: room)).toList(),
                        );
                      }
                    },
                  ),

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
  @override
  State<_SearchRoomsButton> createState() => _SearchRoomsButtonState();
}

class _SearchRoomsButtonState extends State<_SearchRoomsButton> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    String _room = "";

    return CustomTextfieldButton(
      icon: const Icon(Icons.search_rounded),
      labelText: "Buscar habitaciones",
      borderRadius: 20.0,
      borderColor: const Color.fromARGB(255, 117, 52, 246),
      controller: _controller,
      onChanged: (value) {
        setState(() {
          _room = value;
        });
      },
    );
  }
}

/*Habitaciones que estan cerca de la ubicacion del estudiante*/
class _CarouselRooms extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Room> rooms = [
      Room.carrousel(
        imageUrl: "https://i.postimg.cc/6ppVLZCf/room1.jpg",
        title: 'Habitación acogedora',
        address: "Lima, Peru",
      ),
      Room.carrousel(
        imageUrl: "https://i.postimg.cc/6ppVLZCf/room1.jpg",
        title: 'Suite de lujo',
        address: "Lima, Peru",
      ),
      Room.carrousel(
        imageUrl: "https://i.postimg.cc/6ppVLZCf/room1.jpg",
        title: 'Suite de lujo',
        address: "Lima, Peru",
      ),
      Room.carrousel(
        imageUrl: "https://i.postimg.cc/6ppVLZCf/room1.jpg",
        title: 'Habitacion en San Isidro',
        address: "Lima, Peru",
      ),
      Room.carrousel(
        imageUrl: "https://i.postimg.cc/6ppVLZCf/room1.jpg",
        title: 'Suite de lujo',
        address: "Lima, Peru",
      ),
    ];


    return CarouselSlider(
      options: CarouselOptions(
        height: 190.0,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        viewportFraction: 0.6,
      ),
      items: rooms.map((room) {
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
                        Text(
                          room.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
