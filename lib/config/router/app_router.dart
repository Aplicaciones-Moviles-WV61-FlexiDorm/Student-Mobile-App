import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:flexidorm_student_app/presentation/screens/reservations/reserve_rooms.dart';
import 'package:flexidorm_student_app/presentation/screens/reservations/show_reservation_list.dart';
import 'package:flexidorm_student_app/presentation/screens/screens.dart';
import 'package:flexidorm_student_app/presentation/screens/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: SigninScreen.name,
      builder: (context, state) => const SigninScreen(),
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

    GoRoute(
      path: "/profile",
      name: StudentProfile.name,
      builder: (context, state) => const StudentProfile(),
    ),
    GoRoute(
      path: "/profile-edit",
      name: StudentProfileEdit.name,
      builder: (context, state) {
        final student = state.extra as Student;
        return StudentProfileEdit(student: student);
      },
    ),
    GoRoute(
      path: "/room-details",
      name: RoomDetailsScreen.name,
      builder: (context, state) {
        final Room room = state.extra as Room;
        return RoomDetailsScreen(room: room);
      }
    ),
    GoRoute(
      path: "/reserve-rooms",
      name: ReserveRooms.name,
      builder: (context, state) {
        final Room room = state.extra as Room;
        return ReserveRooms(room: room);
      }
    ),
    
    GoRoute(
      path: "/favorites",
      name: FavoriteRooms.name,
      builder: (context, state) => const FavoriteRooms(),
    ),

    GoRoute(
      path: "/settings",
      name: SettingsScreen.name,
      builder: (context, state) => const SettingsScreen(),
    ),

    GoRoute(
      path: "/reservations",
      name: ShowReservationList.name,
      builder: (context, state) => const ShowReservationList(),
    ),

  ]
);