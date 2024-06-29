class Reservation {
  final int reservationId;
  final String date;
  final String hourInit;
  final String hourFinal;
  final String imageUrl;
  final int roomId;

  Reservation({
    required this.reservationId,
    required this.date,
    required this.hourInit,
    required this.hourFinal,
    required this.imageUrl,
    required this.roomId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservationId'],
      date: json['date'],
      hourInit: json['hourInit'],
      hourFinal: json['hourFinal'],
      imageUrl: json['imageUrl'],
      roomId: json['room'],
    );
  }
}