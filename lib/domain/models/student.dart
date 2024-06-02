class Student{
  //int studentId;
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
  //bool verified;
  //String token;

  Student({
    //required this.studentId,
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
    //required this.verified, 
    //required this.token
  });


  factory Student.fromJson(Map<String, dynamic> json) => Student(
    //studentId: json["userId"],
    firstName: json["firstname"],
    lastName: json["lastname"],
    userName: json["username"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    password: json["password"],
    address: json["address"],
    birthDate: DateTime.parse(json["birthDate"]),
    profilePicture: json["profilePicture"],
    gender: json["gender"],
    university: json["university"],
    //token: json["token"],
    //verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    //"userId": studentId,
    "firstname": firstName, 
    "lastname": lastName,
    "username": userName,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "address": address,
    "birthDate": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "profilePicture": profilePicture,
    "gender": gender,
    "university": university,
    //"token": token,
    //"verified": verified,
  };

}


/* 
Respuesta de la API al registrarse:
  {
    "message": "OK",
    "status": "SUCCESS",
    "data": {
      "userId": 11,
      "username": "mica",
      "firstname": "Micaela",
      "lastname": "Nara",
      "phoneNumber": "647923355",
      "email": "micaela@upc.edu.pe",
      "address": "Av. La Mar",
      "birthDate": "2003-04-03",
      "profilePicture": "https://cdn.dribbble.com/users/5534/screenshots/14230133/profile_4x.jpg",
      "gender": "FEMALE",
      "university": "UPC",
      "dtype": "Student",
      "token": "eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJtaWNhZWxhQHVwYy5lZHUucGUiLCJpYXQiOjE3MTcyOTc4NzYsImV4cCI6MTcxOTg4OTg3Niwicm9sZXMiOlsiUk9MRV9VU0VSIl19._UbYiSsFgM89lOuSuEqA5n2qp40g0MDXDUzsRgEWpHUPRQ6OJRFHjkSdqwAm_BJs",
      "enabled": true,
      "verified": false
    }
  }
*/