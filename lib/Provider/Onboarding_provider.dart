import 'package:flutter/foundation.dart';

class OnboardingProvider with ChangeNotifier {
  String _selectedState = "Karnataka";
  List<String> _selectedDistricts = [];
  List<String> _selectedCategories = [];
  List<int> _selectedPublisherIds = [];

  // ✅ Getters
  String get selectedState => _selectedState;
  List<String> get selectedDistricts => _selectedDistricts;
  List<String> get selectedCategories => _selectedCategories;
  List<int> get selectedPublisherIds => _selectedPublisherIds;

  // ✅ State update
  void setSelectedState(String state) {
    _selectedState = state;
    notifyListeners();
  }

  // ✅ Districts toggle
  void toggleDistrict(String district) {
    if (_selectedDistricts.contains(district)) {
      _selectedDistricts.remove(district);
    } else {
      _selectedDistricts.add(district);
    }
    notifyListeners();
  }

  // ✅ Categories toggle
  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  // ✅ Publishers toggle (IDs are int)
  void togglePublisher(int publisherId) {
    if (_selectedPublisherIds.contains(publisherId)) {
      _selectedPublisherIds.remove(publisherId);
    } else {
      _selectedPublisherIds.add(publisherId);
    }
    
    notifyListeners();
  }

  // ✅ Reset everything (if needed later)
  void clearAll() {
    _selectedDistricts.clear();
    _selectedCategories.clear();
    _selectedPublisherIds.clear();
    notifyListeners();
  }
}
