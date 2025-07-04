class Publisher {
  final String name;
  final String logoUrl;
  final String region;

  Publisher({
    required this.name,
    required this.logoUrl,
    required this.region,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      name: json['name'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      region: json['region'] ?? '',
    );
  }
}
