import 'package:flexidorm_student_app/presentation/screens/home/home.dart';
import 'package:flexidorm_student_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: SigninScreen.name,
      builder: (context, state) => const SigninScreen(),
      //builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: "/register-credentials",
      name: SignupScreenCredentials.name,
      builder: (context, state) => const SignupScreenCredentials(),
    ),
    GoRoute(
      path: "/register-info",
      name: SignupScreenPersonalInformation.name,
      builder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        return SignupScreenPersonalInformation(
          email: extra['email'],
          password: extra['password'],
        );
      }
    ),
    GoRoute(
      path: "/home",
      name: Home.name,
      builder: (context, state) => const Home(),
    ),
  ]
);