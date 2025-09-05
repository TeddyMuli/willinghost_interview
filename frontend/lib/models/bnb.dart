class Bnb {
  final String name;
  final String location;
  final String id;
  final double pricePerNight;
  final bool availability;

  Bnb({
    required this.id,
    required this.availability,
    required this.name,
    required this.location,
    required this.pricePerNight,
    });

    factory Bnb.fromJson(Map<String, dynamic> json) {
      return Bnb(
        id: json['id'],
        availability: json['availability'],
        name: json['name'],
        location: json['location'],
        pricePerNight: (json['pricePerNight'] as num).toDouble(),
      );
    }
}
