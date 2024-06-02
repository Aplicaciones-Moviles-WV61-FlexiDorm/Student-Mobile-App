import 'package:flexidorm_student_app/presentation/screens/screens.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_simple_text.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_textfield_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


/*Pantalla de registro de correo y contraseña*/
class SignupScreenCredentials extends StatefulWidget {
  static const String name = "signup_screen_credentials";

  const SignupScreenCredentials({
    super.key
  });

  @override
  State<SignupScreenCredentials> createState() => _SignupScreenCredentialsState();
}

class _SignupScreenCredentialsState extends State<SignupScreenCredentials> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.pop();
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
                _RegisteredButtons(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                ),
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
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const _RegisteredButtons({
    required this.emailController,
    required this.passwordController, 
    required this.confirmPasswordController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfieldButton(
          controller: emailController,
          icon: const Icon(Icons.email),
          labelText: "Correo Electrônico",
          borderColor: const Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
          onChanged: (value) {
          },
        ),
        const SizedBox(height: 20),
        CustomTextfieldButton(
          controller: passwordController,
          icon: const Icon(Icons.password_outlined),
          labelText: "Contraseña",
          borderColor: const Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
          onChanged: (value) {
          },
        ),
        const SizedBox(height: 20),
        CustomTextfieldButton(
          controller: confirmPasswordController,
          icon: const Icon(Icons.password_outlined),
          labelText: "Confirma tu contraseña",
          borderColor:const Color.fromARGB(255, 117, 52, 246),
          borderRadius: 20.0,
          padding: 35,
        ),
        const SizedBox(height: 20),
        _ContinueButton(
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        )
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const _ContinueButton({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          final email = emailController.text;
          final password = passwordController.text;
          final confirmPassword = confirmPasswordController.text;

          if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Por favor, complete todos los campos')),
            );
            return;
          }

          if (password != confirmPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Las contraseñas no coinciden')),
            );
            return;
          }

          // Navegar a la siguiente pantalla con los datos ingresados
          context.pushNamed(
            SignupScreenPersonalInformation.name,
            extra: {
              'email': email,
              'password': password,
            },
          );
        },

        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 117, 52, 246)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CONTINUAR",
              style: TextStyle(
                color: Colors.white,
                height: 3.7,
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward, 
              color: Colors.white
            ),
          ],
        ),
      
      ),
    );
  }
}

class _NavigationLogInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomSimpleText(
          text: "¿Ya tienes una cuenta? ", 
          colorText: Color.fromARGB(255, 117, 52, 246),
        ),
        CustomSimpleText(
          onTap: () => context.pushNamed(SigninScreen.name),
          text: "Inicia sesión aquí", 
          colorText: const Color.fromARGB(255, 117, 52, 246),
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}


