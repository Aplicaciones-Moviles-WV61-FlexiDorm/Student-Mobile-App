class Room{
  final int roomId;
  final String title;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final double price;
  final String nearUniversities;
  final int arrenderId;
  final String imageUrl;

  
  Room.carrousel({
    required this.title,
    required this.address,
    required this.imageUrl,
    this.description = "",
    this.price = 0.0,
    this.nearUniversities = "",
    this.roomId = 0,
    this.arrenderId = 0,
    this.latitude = 0.0,
    this.longitude = 0.0
  });
  

  Room({
    required this.roomId,
    required this.title,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.price,
    required this.nearUniversities,
    required this.latitude,
    required this.longitude,
    required this.arrenderId
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json['roomId'],
      title: json['title'],
      description: json['description'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      nearUniversities: json['nearUniversities'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      arrenderId: json['arrenderId'], 
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "roomId": roomId,
      "title": title,
      "description": description,
      "address": address,
      "imageUrl": imageUrl,
      "price": price,
      "nearUniversities": nearUniversities,
      "latitude": latitude,
      "longitude": longitude,
      "arrenderId": arrenderId
    };
  }

  Room.fromMap(Map<String, dynamic> map)
    : roomId = map['roomId'],
      title = map['title'],
      description = map['description'],
      address = map['address'],
      imageUrl = map['imageUrl'],
      price = map['price'],
      nearUniversities = map['nearUniversities'],
      latitude = map['latitude'],
      longitude = map['longitude'],
      arrenderId = map['arrenderId'];

}

class RoomWithDistance extends Room {
  double distance;

  RoomWithDistance({
    required int roomId,
    required String title,
    required String description,
    required String address,
    required String imageUrl,
    required double price,
    required String nearUniversities,
    required double latitude,
    required double longitude,
    required int arrenderId,
    this.distance = 0.0,
  }) : super(
          roomId: roomId,
          title: title,
          description: description,
          address: address,
          imageUrl: imageUrl,
          price: price,
          nearUniversities: nearUniversities,
          latitude: latitude,
          longitude: longitude,
          arrenderId: arrenderId,
        );
}