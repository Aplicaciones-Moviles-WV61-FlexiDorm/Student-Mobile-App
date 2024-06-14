import 'dart:convert';
import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  Future<Student?> getStudent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? studentJson = preferences.getString("student");
    if (studentJson != null) {
      return Student.fromJson(jsonDecode(studentJson));
    }
    return null;
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("jwt_token");
    await preferences.remove("student");
    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: FutureBuilder<Student?>(
        future: getStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar el perfil"));

          } else if (!snapshot.hasData) {
            return const Center(child: Text("Los datos del perfil no estan disponibles"));

          } else {
            final student = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(student.profilePicture),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${student.firstName} ${student.lastName}',
                    style: const TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '@${student.userName}',
                    style: const TextStyle(
                      fontSize: 16, 
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 40),
                  _infoStudent(Icons.email, "Correo", student.email),
                  _infoStudent(Icons.phone, "Celular", student.phoneNumber),
                  _infoStudent(Icons.cake, "Nacimiento", "${student.birthDate.toLocal()}".split(' ')[0]),
                  _infoStudent(Icons.school, "Universidad", student.university),
                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: CustomElevatedButton(
                      text: "Cerrar Sesión",
                      backgroundColor: const Color.fromARGB(255, 117, 52, 246),
                      onPressed: () => logout(context),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _infoStudent(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
        child: Row(
          children: [
            Icon(icon, size: 30),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
    );
  }
}