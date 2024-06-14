import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentProfileEdit extends StatefulWidget {
  final Student student;
  static const String name = "student_profile_edit";

  const StudentProfileEdit({
    super.key, 
    required this.student
  });

  @override
  State<StudentProfileEdit> createState() => _StudentProfileEditState();
}

class _StudentProfileEditState extends State<StudentProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _profilePictureController;
  final StudentService _studentService = StudentService();

    @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.student.firstName);
    _lastNameController = TextEditingController(text: widget.student.lastName);
    _userNameController = TextEditingController(text: widget.student.userName);
    _emailController = TextEditingController(text: widget.student.email);
    _phoneController = TextEditingController(text: widget.student.phoneNumber);
    _profilePictureController = TextEditingController(text: widget.student.profilePicture);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go("/home/profile");
          }  
        ),
        title: const Text("Editar Perfil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.network(
                "https://cdn-icons-png.flaticon.com/512/1160/1160515.png",
                scale: 5.0,
                width: 130,
                height: 130,
              ),

              const SizedBox(height: 10),
              CustomTextfieldButton(
                icon: const Icon(Icons.person),
                labelText: "Nombre",
                borderColor: const Color.fromARGB(255, 117, 52, 246),
                borderRadius: 20.0,
                padding: 20,
                controller: _firstNameController,
              ),
              const SizedBox(height: 20),
              CustomTextfieldButton(
                icon: const Icon(Icons.person),
                labelText: "Apellido",
                borderColor: const Color.fromARGB(255, 117, 52, 246),
                borderRadius: 20.0,
                padding: 20,
                controller: _lastNameController,
              ),
              const SizedBox(height: 20),
              CustomTextfieldButton(
                icon: const Icon(Icons.account_circle),
                labelText: "Nombre de usuario",
                borderColor: const Color.fromARGB(255, 117, 52, 246),
                borderRadius: 20.0,
                padding: 20,
                controller: _userNameController,
              ),
              const SizedBox(height: 20),
              CustomTextfieldButton(
                icon: const Icon(Icons.email),
                labelText: "Correo",
                borderColor: const Color.fromARGB(255, 117, 52, 246),
                borderRadius: 20.0,
                padding: 20,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              CustomTextfieldButton(
                icon: const Icon(Icons.phone),
                labelText: "Celular",
                borderColor: const Color.fromARGB(255, 117, 52, 246),
                borderRadius: 20.0,
                padding: 20,
                controller: _phoneController,
              ),
              const SizedBox(height: 20),
              CustomTextfieldButton(
                icon: const Icon(Icons.image),
                labelText: "URL de Imagen de Perfil",
                borderColor: const Color.fromARGB(255, 117, 52, 246),
                borderRadius: 20.0,
                padding: 20,
                controller: _profilePictureController,
              ),
              const SizedBox(height: 35),
              CustomElevatedButton(
                text: "Guardar",
                backgroundColor: const Color.fromARGB(255, 138, 93, 229),
                onPressed: _updateProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _updateProfile() async {

    if (_formKey.currentState!.validate()) {
      final updatedStudent = Student(
        studentId: widget.student.studentId,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        userName: _userNameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        password: widget.student.password,
        gender: widget.student.gender,
        address: widget.student.address,
        birthDate: widget.student.birthDate,
        profilePicture: _profilePictureController.text,
        university: widget.student.university,
      );

      final success = await _studentService.updateStudentProfile(updatedStudent);

      if (success) {
        GoRouter.of(context).go("/home/profile");

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el perfil')),
        );
      }

    }
  }
  
}