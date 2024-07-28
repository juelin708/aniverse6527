class Animal {
  int id;
  String animalname;
  String habit;
  String habitats;
  String location;
  String? imageUrl;

  Animal({
    required this.id,
    required this.animalname,
    required this.habit,
    required this.habitats,
    required this.location,
    this.imageUrl,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      animalname: json['animalname'],
      habit: json['habit'],
      habitats: json['habitats'],
      location: json['location'],
      imageUrl: json['imageUrl'],
    );
  }
}
