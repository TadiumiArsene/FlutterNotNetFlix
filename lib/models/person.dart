class Person {
  final int id;
  final String characterName;
  final String name;
  final String? imageURL;
  Person({
    required this.id,
    required this.characterName,
    required this.name,
    this.imageURL,
  });

  Person copyWith({
    int? id,
    String? characterName,
    String? name,
    String? imageURL,
  }) {
    return Person(
      id: id ?? this.id,
      characterName: characterName ?? this.characterName,
      name: name ?? this.name,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      characterName: map['character'],
      name: map['name'],
      imageURL: map['profile_path'],
    );
  }
}
