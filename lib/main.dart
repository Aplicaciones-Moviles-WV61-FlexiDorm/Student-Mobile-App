import 'package:flexidorm_student_app/config/router/app_router.dart';
import 'package:flexidorm_student_app/config/theme/app_theme.dart';
//import 'package:flexidorm_student_app/presentation/providers/signup_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  //final SignupProvider signupProvider = SignupProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( 
      routerConfig: appRouter,
      title: "Flexidorm Student App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).getTheme(),
    );
  }
}
