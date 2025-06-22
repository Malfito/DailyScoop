class OnboardingRequestModel {
  final int userId;
  final String state;
  final String district;
  final List<String> categories;
  final List<int> publisherIds;

  OnboardingRequestModel({
    required this.userId,
    required this.state,
    required this.district,
    required this.categories,
    required this.publisherIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "state": state,
      "district": district,
      "categories": categories,
      "publisherIds": publisherIds,
    };
  }
}
