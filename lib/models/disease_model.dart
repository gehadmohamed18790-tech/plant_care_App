class PlantDisease {
  final int id;
  final String commonName;
  final String scientificName;
  final String description;
  final String solution;
  final String imageUrl;

  PlantDisease({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.description,
    required this.solution,
    required this.imageUrl,
  });

  factory PlantDisease.fromJson(Map<String, dynamic> json) {
    return PlantDisease(
      id: json['id'] ?? 0,
      commonName: json['common_name'] ?? 'Unknown Disease',
      scientificName: json['scientific_name'] ?? '',
      description: json['description'] ?? 'No description available.',
      solution: json['solution'] ?? 'No solution available.',
      imageUrl: (json['images'] != null && (json['images'] as List).isNotEmpty)
          ? json['images'][0]['regular_url'] ?? ''
          : '',
    );
  }
}