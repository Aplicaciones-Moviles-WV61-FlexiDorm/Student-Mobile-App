import 'package:flexidorm_student_app/config/router/app_router.dart';
import 'package:flexidorm_student_app/config/theme/app_theme.dart';
import 'package:flexidorm_student_app/presentation/providers/home_provider.dart';
import 'package:flexidorm_student_app/presentation/providers/location_provider.dart';
import 'package:flexidorm_student_app/presentation/providers/room_provider.dart';
import 'package:flexidorm_student_app/presentation/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp.router( 
      routerConfig: appRouter,
      title: "Flexidorm Student App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).getTheme(),
      )
    );
  }
}

