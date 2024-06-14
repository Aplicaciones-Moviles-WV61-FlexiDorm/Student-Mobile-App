class Room{
  final int roomId;
  final String title;
  final String description;
  final String address;
  final String imageUrl;
  final double price;
  final String nearUniversities;

  
  Room.carrousel({
    this.roomId = 0,
    required this.title,
    this.description = "",
    required this.address,
    required this.imageUrl,
    this.price = 0.0,
    this.nearUniversities = ""
  });
  

  Room({
    required this.roomId,
    required this.title,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.price,
    required this.nearUniversities
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
    );
  }

}