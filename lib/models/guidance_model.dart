class PlantGuidance {
  final int id;
  final int speciesId;
  final String commonName;
  final List<GuidanceSection> sections;

  PlantGuidance({
    required this.id,
    required this.speciesId,
    required this.commonName,
    required this.sections,
  });

  factory PlantGuidance.fromJson(Map<String, dynamic> json) {
    return PlantGuidance(
      id: json['id'] ?? 0,
      speciesId: json['species_id'] ?? 0,
      commonName: json['common_name'] ?? 'Unknown Plant',
      sections: json['section'] != null
          ? (json['section'] as List)
              .map((item) => GuidanceSection.fromJson(item))
              .toList()
          : [],
    );
  }
}

class GuidanceSection {
  final int id;
  final String type;
  final String description;

  GuidanceSection({
    required this.id,
    required this.type,
    required this.description,
  });

  factory GuidanceSection.fromJson(Map<String, dynamic> json) {
    return GuidanceSection(
      id: json['id'] ?? 0,
      type: json['type'] ?? 'General',
      description: json['description'] ?? 'No guidance details available.',
    );
  }
}