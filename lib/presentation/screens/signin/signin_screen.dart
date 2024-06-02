import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_simple_text.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_titles.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _LogoApp(),
                const SizedBox(height: 50),
                _WelcomeUser(),
                const SizedBox(height: 40),
                _LogInButtons(),
                const SizedBox(height: 20),
                _NavigationRegisterScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "https://i.postimg.cc/0NWYJ5WQ/logoApp.png",
          scale: 4.0,
        ),
        Image.network(
          "https://i.postimg.cc/bvN0JSRW/logo-Name-App.png",
          scale: 6.0,
        ),
      ],
    );
  }
}

class _WelcomeUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CommonTitles(
          text:  "Bienvenido de nuevo",
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 5),
        CommonTitles(
          text: "Inicie sesión en su cuenta existente de Flexidorm",
          fontSize: 12,
          color: Colors.black45,
          fontWeight: FontWeight.normal,
        ),
      ],
    );
  }
}

class _LogInButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomTextfieldButton(
          icon: Icon(Icons.person),
          labelText: "Correo Electrónico",
          borderColor: Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
        ),
        SizedBox(height: 20),

        CustomTextfieldButton(
          icon: Icon(Icons.password_outlined),
          labelText: "Contraseña",
          borderColor: Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
        ),

        SizedBox(height: 20),
        CustomElevatedButton(
          text: "INICIAR SESIÓN", 
          backgroundColor: Color.fromARGB(255, 117, 52, 246),
        ),
      ],
    );
  }
}

class _NavigationRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSimpleText(
          text: "¿No tienes una cuenta? ", 
          colorText: Color.fromARGB(255, 117, 52, 246),
        ),
        CustomSimpleText(
          text: "Registrate", 
          colorText: Color.fromARGB(255, 117, 52, 246),
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}






