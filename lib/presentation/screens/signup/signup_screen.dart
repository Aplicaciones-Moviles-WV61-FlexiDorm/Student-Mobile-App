import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_simple_text.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flutter/material.dart';


/*Pantalla de registro de correo y contraseña*/
class SignupScreenCredentials extends StatelessWidget {
  const SignupScreenCredentials({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {

          },
          color: const Color.fromARGB(255, 117, 52, 246),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _WelcomeUser(),
                const SizedBox(height: 50),
                _RegisteredButtons(),
                const SizedBox(height: 20),
                _NavigationLogInScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
      Text(
        "¡Empecemos Estudiante!",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        "Crea una cuenta en Flexidorm y obtén todas las funcionalidades",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
      ],
    );
  }
}

class _RegisteredButtons extends StatelessWidget {
  //const _RegisteredButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomTextfieldButton(
          icon: Icon(Icons.email),
          labelText: "Correo Electrônico",
          borderColor: Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
        ),
        SizedBox(height: 20),
        CustomTextfieldButton(
          icon: Icon(Icons.password_outlined),
          labelText: "Contraseña",
          borderColor: Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
        ),
        SizedBox(height: 20),
        CustomTextfieldButton(
          icon: Icon(Icons.password_outlined),
          labelText: "Confirma tu contraseña",
          borderColor: Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
        ),
        SizedBox(height: 20),
        CustomElevatedButton(
          text: "CONTINUAR", 
          backgroundColor: Color.fromARGB(255, 117, 52, 246),
        ),
      ],
    );
  }
}

class _NavigationLogInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSimpleText(
          text: "¿Ya tienes una cuenta? ", 
          colorText: Color.fromARGB(255, 117, 52, 246),
        ),
        CustomSimpleText(
          text: "Inicia sesión aquí", 
          colorText: Color.fromARGB(255, 117, 52, 246),
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}



/*Pantalla de registro de informacion del estudiante*/
class SignupScreenPersonalInformation extends StatelessWidget {
  const SignupScreenPersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {

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
                _PersonalInformationButtons(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _BirthDateButton(),
                    const SizedBox(width: 40),
                    _GenderButton()
                  ],
                ),
                const SizedBox(height: 40),
                const CustomElevatedButton(
                  text: "REGISTRARME", 
                  backgroundColor: Color.fromARGB(255, 117, 52, 246),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class _PersonalInformationButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _CommonButtons(text: "Nombre", icon: Icons.person_3_sharp),
        SizedBox(height: 20),
        _CommonButtons(text: "Apellido", icon: Icons.person_2_rounded),
        SizedBox(height: 20),
        _CommonButtons(text: "Nombre de usuario", icon: Icons.person_3),
        SizedBox(height: 20),
        _CommonButtons(text: "Universidad", icon: Icons.school),
        SizedBox(height: 20),
        _CommonButtons(text: "Celular", icon: Icons.phone),
      ],
    );
  }
}

class _CommonButtons extends StatelessWidget {
  final String text;
  final IconData icon;

  const _CommonButtons({
    required this.text, 
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextfieldButton(
          icon: Icon(icon),
          labelText: text,
          borderColor: const Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
    );
  }
}

class _BirthDateButton extends StatelessWidget {
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
          // Guardar la fecha de nacimiento en una variable de instancia o en un provider
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

class _GenderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Selecciona tu género'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Masculino'),
                    onTap: () {
                      // Guardar el género en una variable de instancia o en un provider
                      print('Género seleccionado: Masculino');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Femenino'),
                    onTap: () {
                      // Guardar el género en una variable de instancia o en un provider
                      print('Género seleccionado: Femenino');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Otro'),
                    onTap: () {
                      // Guardar el género en una variable de instancia o en un provider
                      print('Género seleccionado: Otro');
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