import 'package:flexidorm_student_app/domain/models/rental.dart';
import 'package:flexidorm_student_app/domain/models/room.dart';
import 'package:flexidorm_student_app/domain/models/student.dart';
import 'package:flexidorm_student_app/presentation/providers/student_provider.dart';
import 'package:flexidorm_student_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flexidorm_student_app/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ReserveRooms extends StatelessWidget {
  static const String name = "reserve_rooms";
  final Room room;

  const ReserveRooms({
    super.key, 
    required this.room, 
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController startTimeController = TextEditingController();
    final TextEditingController endTimeController = TextEditingController();
    final TextEditingController observationController = TextEditingController();

    final studentProvider = Provider.of<StudentProvider>(context);
    final student = studentProvider.student;

    if (student == null) {
      return const Center(child: Text("No se ha encontrado información del estudiante."));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/home");
          },
        ),
        title: const Text("Reservar Habitación"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _informationReserve(Icons.person, "${student.firstName} ${student.lastName}"),
            const SizedBox(height: 20),
            _informationReserve(Icons.phone, student.phoneNumber),
            const SizedBox(height: 20),
            _informationReserve(Icons.email, student.email),
            const SizedBox(height: 20),
            CustomTimePickerFieldButton(
              labelText: "Hora de inicio",
              controller: startTimeController,
            ),
            const SizedBox(height: 20),
            CustomTimePickerFieldButton(
              labelText: "Hora de fin",
              controller: endTimeController,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: observationController,
              decoration: InputDecoration(
                labelText: "Observaciones",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Precio total: S/.${room.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 20),
            CustomElevatedButton(
              text: "RESERVAR AHORA",
              backgroundColor: const Color.fromARGB(255, 135, 84, 235),
              widthButton: 350,
              onPressed: () {
                _registerReservation(
                  startTimeController.text,
                  endTimeController.text,
                  observationController.text,
                  student,
                  room,
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationReserve(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 30),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void _registerReservation(
    String startTime,
    String endTime,
    String observation,
    Student? student,
    Room room,
    BuildContext context,
  ) async {

    if (student == null) {
      print("ERROR: El Student es nulo");
      return;
    }

    final reservation = Rental(
      date: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now()),
      phone: student.phoneNumber,
      email: student.email,
      observation: observation,
      totalPrice: room.price,
      hourInit: startTime,
      hourFinal: endTime,
      studentId: student.studentId.toString(),
      roomId: room.roomId,
      imageUrl: room.imageUrl,
      arrenderId: room.arrenderId.toString(),
      favorite: true,
      movement: "new"
    );

    final success = await StudentService().registerReservation(reservation.toJson());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: success ? const Text("Reserva registrada correctamente") : const Text("Error al registrar reserva"),
        backgroundColor: const Color.fromARGB(255, 162, 85, 238), 
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )
    );

    if (success) {
      context.go("/home");
    }

    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Error al registrar reserva"),
          backgroundColor: const Color.fromARGB(255, 238, 96, 86), 
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

}


class CustomTimePickerFieldButton extends StatelessWidget {
  final Icon? icon;
  final String? labelText;
  final double borderRadius;
  final Color borderColor;
  final double padding;
  final TextEditingController? controller;
  
  const CustomTimePickerFieldButton({
    super.key, 
    this.icon, 
    this.labelText, 
    this.borderRadius = 10.0,
    this.borderColor = const Color.fromARGB(255, 157, 73, 241),
    this.padding = 4.0, 
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: TextFormField(
          readOnly: true,
          controller: controller,
          onTap: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              final now = DateTime.now();
              final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
              final formattedTime = DateFormat('HH:mm').format(dt);
              controller?.text = formattedTime;
            }
          },
          decoration: InputDecoration(
            prefixIcon: icon,
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
          ),
        ),
      ),
    );
  }
}





