import 'package:flutter/foundation.dart';
import '../data/repositories/user_defined_values_repository.dart';

class UserDefinedValuesProvider with ChangeNotifier {
  final UserDefinedValuesRepository repository;

  UserDefinedValuesProvider(this.repository);

  // Cache for values by category
  final Map<String, List<String>> _valuesCache = {};
  final Map<String, List<String>> _defaultValuesCache = {};

  // Get values for a specific category
  Future<List<String>> getValues(String category) async {
    if (_valuesCache.containsKey(category)) {
      return _valuesCache[category]!;
    }

    final values = await repository.getValues(category);
    _valuesCache[category] = values;
    return values;
  }

  // Get default values for a specific category
  Future<List<String>> getDefaultValues(String category) async {
    if (_defaultValuesCache.containsKey(category)) {
      return _defaultValuesCache[category]!;
    }

    final values = await repository.getDefaultValues(category);
    _defaultValuesCache[category] = values;
    return values;
  }

  // Add a new value to a category
  Future<void> addValue(String category, String value) async {
    await repository.addValue(category, value);
    
    // Update cache
    if (_valuesCache.containsKey(category)) {
      if (!_valuesCache[category]!.contains(value)) {
        _valuesCache[category]!.add(value);
        _valuesCache[category]!.sort();
      }
    } else {
      _valuesCache[category] = [value];
    }
    
    notifyListeners();
  }

  // Remove a value from a category
  Future<void> removeValue(String category, String value) async {
    await repository.removeValue(category, value);
    
    // Update cache
    if (_valuesCache.containsKey(category)) {
      _valuesCache[category]!.remove(value);
    }
    
    notifyListeners();
  }

  // Set a value as default
  Future<void> setDefaultValue(String category, String value, bool isDefault) async {
    await repository.setDefaultValue(category, value, isDefault);
    
    // Refresh default values cache
    _defaultValuesCache.remove(category);
    await getDefaultValues(category);
    
    notifyListeners();
  }

  // Initialize default values
  Future<void> initializeDefaultValues() async {
    await repository.initializeDefaultValues();
    
    // Clear cache to force refresh
    _valuesCache.clear();
    _defaultValuesCache.clear();
    
    notifyListeners();
  }

  // Refresh values for a specific category
  Future<void> refreshValues(String category) async {
    _valuesCache.remove(category);
    _defaultValuesCache.remove(category);
    await getValues(category);
    await getDefaultValues(category);
    notifyListeners();
  }

  // Load all values for all categories
  Future<void> loadAllValues() async {
    final categories = [
      'symbols',
      'exchanges',
      'strategies',
      'entryFeeRates',
      'exitFeeRates',
      'entryMentalStates',
      'exitMentalStates',
      'trackings',
      'mistakes',
      'checklist',
    ];
    
    for (final category in categories) {
      await getValues(category);
    }
  }

  // Clear all caches
  void clearCache() {
    _valuesCache.clear();
    _defaultValuesCache.clear();
    notifyListeners();
  }
}
