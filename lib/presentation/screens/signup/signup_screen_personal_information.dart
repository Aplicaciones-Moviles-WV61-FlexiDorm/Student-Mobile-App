import 'dart:convert';
import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*Pantalla de registro de informacion del estudiante*/
class SignupScreenPersonalInformation extends StatefulWidget {
  static const String name = "signup_screen_personal_information";
  final String email;
  final String password;
  
  const SignupScreenPersonalInformation({
    super.key, 
    required this.email,
    required this.password,
  });

  @override
  State<SignupScreenPersonalInformation> createState() => _SignupScreenPersonalInformationState();
}

class _SignupScreenPersonalInformationState extends State<SignupScreenPersonalInformation> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();

  String _gender = "";
  DateTime? _birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
          color: const Color.fromARGB(255, 117, 52, 246),
        )
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Estás a un paso de usar Flexidorm ...",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                _PersonalInformationButtons(
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  userNameController: _userNameController,
                  phoneNumberController: _phoneNumberController,
                  universityController: _universityController,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _BirthDateButton(
                      onDateSelected: (date) {
                        setState(() {
                          _birthDate = date;
                        });
                      },
                    ),
                    const SizedBox(width: 40),
                    _GenderButton(
                      onGenderSelected: (gender) {
                        setState(() {
                          _gender = gender;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                CustomElevatedButton(
                  text: "REGISTRARME", 
                  backgroundColor: const Color.fromARGB(255, 117, 52, 246),
                  onPressed: _register
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  void _register() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final userName = _userNameController.text;
    final phoneNumber = _phoneNumberController.text;
    final university = _universityController.text;
    final email = widget.email;
    final password = widget.password;

    if (firstName.isEmpty || lastName.isEmpty || userName.isEmpty || phoneNumber.isEmpty || university.isEmpty || _birthDate == null || _gender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    final student = Student(

      firstName: firstName,
      lastName: lastName,
      userName: userName,
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      gender: _gender,
      birthDate: _birthDate!,
      university: university,
    );

    print('Student JSON: ${jsonEncode(student.toJson())}');

    try {
      final studentService = StudentService();
      final response = await studentService.registerStudent(student);

      if (!mounted) {return;}

      if (response.status.toLowerCase() == "success") {
        print('Registro exitoso: ${response.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro exitoso: ${response.message}')),
        );
        print('Redirigiendo a la pantalla de inicio de sesión');

        context.go("/");

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
  
}


/*Botones de informacion personal*/
class _PersonalInformationButtons extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController userNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController universityController;

  const _PersonalInformationButtons({
    required this.firstNameController,
    required this.lastNameController,
    required this.userNameController,
    required this.phoneNumberController,
    required this.universityController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CommonButtons(
          controller: firstNameController,
          text: "Nombre", 
          icon: Icons.person_3_sharp,
        ),
        const SizedBox(height: 20),
        _CommonButtons(
          controller: lastNameController,
          text: "Apellido", 
          icon: Icons.person_2_rounded,
        ),
        const SizedBox(height: 20),
        _CommonButtons(
          controller: userNameController,
          text: "Nombre de usuario", 
          icon: Icons.person_3,
        ),
        const SizedBox(height: 20),
        _CommonButtons(
          controller: universityController,
          text: "Universidad", 
          icon: Icons.school,
        ),
        const SizedBox(height: 20),
        _CommonButtons(
          controller: phoneNumberController,
          text: "Celular", 
          icon: Icons.phone,
        ),
      ],
    );
  }
}

class _CommonButtons extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextEditingController? controller;

  const _CommonButtons({
    required this.text,
    required this.icon, 
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextfieldButton(
          icon: Icon(icon),
          labelText: text,
          borderColor: const Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
          controller: controller
    );
  }
}

/*Botones para la fecha de nacimiento*/
class _BirthDateButton extends StatelessWidget{

  final ValueChanged<DateTime> onDateSelected;

  const _BirthDateButton({
    required this.onDateSelected
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (selectedDate!= null) {
          onDateSelected(selectedDate);
          print('Fecha de nacimiento seleccionada: $selectedDate');
        }
      },
      text: 'Nacimiento',
      fontSize: 12,
      backgroundColor:const Color.fromARGB(198, 153, 101, 255),
      widthButton: 120,
    );
  }
}


/*Botones para elegir el genero*/
class _GenderButton extends StatelessWidget{
  final ValueChanged<String> onGenderSelected;
  const _GenderButton({required this.onGenderSelected});


  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Selecciona tu género"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text("Masculino"),
                    onTap: () {
                      print("Género seleccionado: Masculino");
                      onGenderSelected("MALE");
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text("Femenino"),
                    onTap: () {
                      print("Género seleccionado: Femenino");
                      onGenderSelected("FEMALE");
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text("Otro"),
                    onTap: () {
                      print("Género seleccionado: Otro");
                      //onGenderSelected("Otro");
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      text: 'Género',
      fontSize: 12,
      backgroundColor: const Color.fromARGB(198, 153, 101, 255),
      widthButton: 120,
    );
  }
}