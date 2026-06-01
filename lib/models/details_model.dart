class PlantDetails {
  final int id;
  final String commonName;
  final String description;
  final String type;
  final String cycle;
  final String watering;
  final String wateringBenchmark;
  final String imageUrl;
  final String careLevel;
  final List<dynamic> sunlight;

  PlantDetails({
    required this.id,
    required this.commonName,
    required this.description,
    required this.type,
    required this.cycle,
    required this.watering,
    required this.wateringBenchmark,
    required this.imageUrl,
    required this.careLevel,
    required this.sunlight,
  });

  factory PlantDetails.fromJson(Map<String, dynamic> json) {
    return PlantDetails(
      id: json['id'] ?? 0,
      commonName: json['common_name'] ?? 'Unknown Plant',
      description: json['description'] ?? 'No description available.',
      type: json['type'] ?? 'Unknown Type',
      cycle: json['cycle'] ?? 'Unknown Cycle',
      watering: json['watering'] ?? 'Regular',
      careLevel: json['care_level'] ?? 'Medium',
      sunlight: json['sunlight'] ?? [],
      
  
      wateringBenchmark: json['watering_general_benchmark'] != null
          ? "${json['watering_general_benchmark']['value'] ?? ''} ${json['watering_general_benchmark']['unit'] ?? ''}"
          : 'No benchmark available',
          
      imageUrl: json['default_image'] != null 
          ? json['default_image']['regular_url'] ?? '' 
          : '',
    );
  }
}