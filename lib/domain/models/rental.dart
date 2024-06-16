class Rental {
  String date;
  String phone;
  String email;
  String observation;
  double totalPrice;
  String hourInit;
  String hourFinal;
  String studentId;
  int roomId;
  String imageUrl;
  bool favorite;
  String arrenderId;
  String movement;

  Rental({
    required this.date,
    required this.phone,
    required this.email,
    required this.observation,
    required this.totalPrice,
    required this.hourInit,
    required this.hourFinal,
    required this.studentId,
    required this.roomId,
    required this.imageUrl,
    this.favorite = true,
    required this.arrenderId,
    this.movement = "ok",
  });

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "phone": phone,
      "email": email,
      "observation": observation,
      "totalPrice": totalPrice,
      "hourInit": hourInit,
      "hourFinal": hourFinal,
      "student": studentId,
      "room": roomId,
      "imageUrl": imageUrl,
      "favorite": favorite,
      "arrenderId": arrenderId,
      "movement": movement,
    };
  }
}