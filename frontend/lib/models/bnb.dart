class Bnb {
  final String name;
  final String location;
  final int id;
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
    availability: json['availability'] is bool
        ? json['availability']
        : json['availability'] == 1,
    name: json['name'],
    location: json['location'],
    pricePerNight: (json['pricePerNight'] != null)
        ? (json['pricePerNight'] as num).toDouble()
        : 0.0,
  );
}
}
