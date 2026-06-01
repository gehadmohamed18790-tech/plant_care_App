class Plant {
  final int id;
  final String commonName;
  final String genus;
  final String imageUrl;

  Plant({
    required this.id,
    required this.commonName,
    required this.genus,
    required this.imageUrl,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] ?? 0,
      commonName: json['common_name'] ?? 'Unknown Plant', 
      genus: json['genus'] ?? 'Unknown Genus',
      imageUrl: json['default_image'] != null 
          ? json['default_image']['regular_url'] ?? '' 
          : '',
    );
  }

  get defaultImage => null;

  String? get cycle => null;

  get sunlight => null;
}