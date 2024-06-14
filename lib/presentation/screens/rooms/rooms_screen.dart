import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flutter/material.dart';



class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _ProfileImage(),
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
                  _Welcome(),
                  const SizedBox(height: 20),
                  _SearchRoomsButton(),
                  const SizedBox(height: 20),
                  _CarouselRooms()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _ProfileImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage: NetworkImage(
        "https://th.bing.com/th/id/OIP.cf140NJe-x3ltcL-d1Nf9gAAAA?rs=1&pid=ImgDetMain"
      ),
    );
  }
}

class _Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Hola! Lizet Bienvenida",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
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



class _CarouselRooms extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Room> rooms = [
      Room(
        imageUrl: "https://th.bing.com/th/id/R.6863d111be607a0a704abb81bdbfbaa2?rik=D%2fIYj42uLnQfaA&pid=ImgRaw&r=0",
        title: 'Habitación acogedora',
        address: "Lima, Peru",
      ),
      Room(
        imageUrl: "https://th.bing.com/th/id/R.38656fd1b5b45c8ed96aae90747d331c?rik=1nNWXYH0%2fE3F8w&pid=ImgRaw&r=0",
        title: 'Suite de lujo',
        address: "Lima, Peru",
      ),
      Room(
        imageUrl: "https://th.bing.com/th/id/R.38656fd1b5b45c8ed96aae90747d331c?rik=1nNWXYH0%2fE3F8w&pid=ImgRaw&r=0",
        title: 'Suite de lujo',
        address: "Lima, Peru",
      ),
      Room(
        imageUrl: "https://th.bing.com/th/id/R.38656fd1b5b45c8ed96aae90747d331c?rik=1nNWXYH0%2fE3F8w&pid=ImgRaw&r=0",
        title: 'Habitacion en San Isidro',
        address: "Lima, Peru",
      ),
      Room(
        imageUrl: "https://th.bing.com/th/id/R.38656fd1b5b45c8ed96aae90747d331c?rik=1nNWXYH0%2fE3F8w&pid=ImgRaw&r=0",
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

