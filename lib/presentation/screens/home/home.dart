import 'package:flexidorm_student_app/presentation/providers/home_provider.dart';
import 'package:flexidorm_student_app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String name = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Widget> _tabs = [
    const RoomsScreen(),
    const FavoriteRooms(),
    const StudentProfile(),
  ];

  @override
    Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: _tabs[homeProvider.currentIndex],
      bottomNavigationBar:  BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 117, 52, 246),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: "Favorites"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile"
          ),
          
        ],
        currentIndex: homeProvider.currentIndex,
        onTap: (value) {
          setState(() {
            homeProvider.updateIndex(value);
          });
        },
      ),
    );
  }

}