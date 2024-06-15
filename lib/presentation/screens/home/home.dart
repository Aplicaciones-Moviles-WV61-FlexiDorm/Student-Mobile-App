import 'package:flexidorm_student_app/presentation/providers/home_provider.dart';
import 'package:flexidorm_student_app/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  static const String name = "home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //int _currentIndex = 0;
  //static int currentIndex = 0;

  /*
  Future<void> loadLastIndex() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      currentIndex = preferences.getInt('lastIndex') ?? 0;
    });
  }
  



  Future<void> _saveLastIndex() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('lastIndex', currentIndex);
  }

  @override
  void initState() {
    super.initState();
    loadLastIndex();
  }
  

  @override
  void dispose() {
    _saveLastIndex();
    super.dispose();
  }
  */

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
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