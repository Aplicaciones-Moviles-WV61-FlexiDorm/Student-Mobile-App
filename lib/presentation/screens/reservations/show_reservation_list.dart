import 'package:flexidorm_student_app/domain/models/reservation.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/presentation/providers/reservation_provider.dart';
import 'package:flexidorm_student_app/presentation/providers/student_provider.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShowReservationList extends StatelessWidget {
  static const String name = "show_reservation_list";
  const ShowReservationList({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final student = studentProvider.student;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reserved Rooms"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/home");
          },
        ),
      ),
      body: student == null 
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : ReservedList(studentId: student.studentId.toString())
    );
  }
}

class ReservedList extends StatefulWidget {
  final String studentId;
  const ReservedList({
    super.key, 
    required this.studentId
  });

  @override
  State<ReservedList> createState() => _ReservedListState();
}

class _ReservedListState extends State<ReservedList> {
    @override
  void initState() {
    super.initState();
    final reservationsProvider = Provider.of<ReservationProvider>(context, listen: false);
    reservationsProvider.fetchReservations(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReservationProvider>(
      builder: (context, reservationsProvider, child) {
        final reservations = reservationsProvider.reservations;

        if (reservations.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];
            return ReservedItem(reservation: reservation);
          },
        );
      },
    );
  }
}

class ReservedItem extends StatelessWidget {
  final Reservation reservation;
  const ReservedItem({
    super.key, 
    required this.reservation
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.network(
                  reservation.imageUrl,
                  height: width,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<Room>(
                      future: StudentService().fetchRoom(reservation.roomId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();

                        } else if (snapshot.hasError) {

                          return Text('Error: ${snapshot.error}');

                        } else {

                          final room = snapshot.data!;
                          final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(reservation.date));

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                room.address,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Inicio: ${reservation.hourInit}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Fin: ${reservation.hourFinal}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Fecha: $formattedDate",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.done,
                      size: 20,
                      color: Color.fromARGB(255, 12, 134, 45),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}