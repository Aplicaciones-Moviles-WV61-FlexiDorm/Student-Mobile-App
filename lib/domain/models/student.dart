class Student{
  int? studentId;
  String firstName;
  String lastName;
  String userName;
  String phoneNumber;
  String email;
  String password;
  String gender;
  String address;
  DateTime birthDate;
  String profilePicture;
  String university;

  Student({
    this.studentId,
    required this.firstName,
    required this.lastName,
    required this.userName, 
    required this.phoneNumber, 
    required this.email, 
    required this.password,
    required this.gender, 
    this.address = "Av. La Mar", 
    required this.birthDate, 
    this.profilePicture = "https://www.pngarts.com/files/10/Default-Profile-Picture-PNG-Free-Download.png", 
    required this.university, 
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    studentId: json["userId"],
    firstName: json["firstname"] ?? "",
    lastName: json["lastname"] ?? "",
    userName: json["username"] ?? "",
    phoneNumber: json["phoneNumber"] ?? "",
    email: json["email"] ?? "",
    password: json["password"] ?? "",
    address: json["address"] ?? "",
    birthDate: DateTime.parse(json["birthDate"] ?? "1999-01-01"),
    profilePicture: json["profilePicture"],
    gender: json["gender"],
    university: json["university"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "userId": studentId,
    "firstname": firstName, 
    "lastname": lastName,
    "username": userName,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "address": address,
    //"birthDate": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "birthDate": birthDate.toIso8601String(),
    "profilePicture": profilePicture,
    "gender": gender,
    "university": university,
  };

}
