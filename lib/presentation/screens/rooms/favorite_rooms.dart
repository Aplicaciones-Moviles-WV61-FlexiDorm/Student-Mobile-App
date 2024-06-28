import 'package:flexidorm_student_app/dao/room_dao.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flutter/material.dart';

class FavoriteRooms extends StatelessWidget {
  static const String name = "favorite_rooms";
  const FavoriteRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Rooms"),
      ),
      body: const FavoriteList()
    );
  }
}


class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<Room> _favorites = [];
  final RoomDao _roomDao = RoomDao();

  fetchFavorites (){
    _roomDao.fetchFavorites().then(
      (value) {
        if (mounted) {
          setState(() {
            _favorites = value;
          });
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    fetchFavorites();

    return ListView.builder(
      itemCount: _favorites.length,
      itemBuilder: (context, index) => FavoriteItem(
        roomFavorite: _favorites[index],
        callback: (){
          _roomDao.delete(_favorites[index]);
        },
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final Room roomFavorite;
  final Function callback;

  const FavoriteItem({
    super.key, 
    required this.roomFavorite, 
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 4;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.network(
                  roomFavorite.imageUrl,
                  height: width,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomFavorite.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      roomFavorite.address,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "S/.${roomFavorite.price.toStringAsFixed(2)} por hora",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.linear_scale,
                      size: 20,
                      color: Color.fromARGB(255, 117, 52, 246),
                    ),
                  ],
                ),
              )
            ),
            IconButton(
              onPressed: (){
                callback();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              )
            )
          ],
        ),
      ),
    );
  }
}