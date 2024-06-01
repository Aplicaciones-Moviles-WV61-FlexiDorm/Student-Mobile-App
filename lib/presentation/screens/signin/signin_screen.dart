import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_titles.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network(
              "https://i.postimg.cc/0NWYJ5WQ/logoApp.png"
            ),
            const SizedBox(height: 20),
            const CommonTitles(
              text:  "Bienvenido de nuevo",
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 5),
            const CommonTitles(
              text: "Inicie sesión en su cuenta existente de Flexidorm",
              fontSize: 20,
              color: Colors.transparent,
              fontWeight: FontWeight.normal,
            ),
            const SizedBox(height: 10),
            CustomTextfieldButton(
              icon: const Icon(Icons.person),
              labelText: "Correo Electrónico",
              borderColor: const Color.fromARGB(255, 117, 52, 246),
            ),
            const SizedBox(height: 5),
            CustomTextfieldButton(
              icon: const Icon(Icons.password_outlined),
              labelText: "Contraseña",
              borderColor: const Color.fromARGB(255, 117, 52, 246),
            ),
            const SizedBox(height: 10),
            const CustomElevatedButton(
              text: "Iniciar Sesión", 
              color: Color.fromARGB(255, 117, 52, 246),
            ),
          ],
        ),
      ),
    );
  }
}

