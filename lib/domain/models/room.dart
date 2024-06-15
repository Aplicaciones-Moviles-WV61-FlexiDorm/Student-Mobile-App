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

}