class Room{
  final String title;
  final String description;
  final String address;
  final String imageUrl;
  final double price;
  final String nearUniversities;

  Room({
    required this.title,
    this.description = "",
    required this.address,
    required this.imageUrl,
    this.price = 0.0,
    this.nearUniversities = ""
  });
}