import 'package:flexidorm_student_app/presentation/screens/signup/signup_screen_credentials.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_simple_text.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_titles.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatelessWidget {
  static const String name = "signin_screen";
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

class _LogInButtons extends StatefulWidget {
  @override
  State<_LogInButtons> createState() => _LogInButtonsState();
}

class _LogInButtonsState extends State<_LogInButtons> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StudentService _studentService = StudentService();

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final response = await _studentService.login(email, password);

    if (!mounted) {return;}
    if (response != null && response['status'] == 'SUCCESS') {
      //final token = response['data']['token'];
      context.go("/home");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de autenticación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfieldButton(
          icon: const Icon(Icons.person),
          labelText: "Correo Electrónico",
          borderColor: const Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
          controller: _emailController,
        ),
        const SizedBox(height: 20),

        CustomTextfieldButton(
          icon: const Icon(Icons.password_outlined),
          labelText: "Contraseña",
          borderColor: const Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
          controller: _passwordController,
        ),

        const SizedBox(height: 20),
        CustomElevatedButton(
          text: "INICIAR SESIÓN", 
          backgroundColor: const Color.fromARGB(255, 117, 52, 246),
          onPressed: _login,
        ),
      ],
    );
  }
}

class _NavigationRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomSimpleText(
          text: "¿No tienes una cuenta? ", 
          colorText: Color.fromARGB(255, 117, 52, 246),
        ),
        CustomSimpleText(
          onTap: () => context.pushNamed(SignupScreenCredentials.name),
          text: "Registrate", 
          colorText: const Color.fromARGB(255, 117, 52, 246),
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}






