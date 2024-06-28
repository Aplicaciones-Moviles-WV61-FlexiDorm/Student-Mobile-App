import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexidorm_student_app/dao/room_dao.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/presentation/screens/maps/animated_markers_map.dart';
import 'package:flexidorm_student_app/presentation/providers/room_provider.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Room room;
  static const String name = "room_detail_screen";
  const RoomDetailsScreen({super.key, required this.room});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  bool _isFavorite = false;
  final RoomDao _roomDao = RoomDao();

  checkFavorite(){
    _roomDao.isFavorite(widget.room).then(
      (value) {
        if(mounted) {
          setState(() {
            _isFavorite = value;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkFavorite();
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/home");
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        widget.room.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                      _isFavorite 
                        ? _roomDao.insert(widget.room) 
                        : _roomDao.delete(widget.room);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isFavorite 
                          ? const Color.fromARGB(255, 245, 167, 161)
                          : Colors.black.withOpacity(0.5),
                      ),
                      child: Icon(
                        Icons.favorite_sharp,
                        size: 20,
                        color: _isFavorite 
                          ? const Color.fromARGB(255, 229, 37, 24)
                          : Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => AnimatedMarkersMap(
                            selectedRoom: widget.room, 
                            rooms: roomProvider.rooms,
                          )
                        )
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: const Icon(
                        Icons.map,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _RoomInformation(room: widget.room),
          ],
        ),
      ),
    );
  }
}

class _RoomInformation extends StatelessWidget {
  const _RoomInformation({
    required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            room.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.money_outlined, color: Colors.black),
              const SizedBox(width: 20),
              Text(
                "S/.${room.price.toStringAsFixed(2)} por hora",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 174, 85, 238),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            room.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            room.address,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            room.nearUniversities,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child:  CustomElevatedButton(
              text: "RESERVAR", 
              backgroundColor: const Color.fromARGB(255, 135, 84, 235),
              widthButton: 350,
              onPressed: () {
                context.go("/reserve-rooms", extra: room);
              },
            ),
          ),

        ],
      ),
    );
  }
}

