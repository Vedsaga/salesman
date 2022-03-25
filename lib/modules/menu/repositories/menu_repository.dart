// third part imports:

// project imports:
import 'package:salesman/core/hive/boxes.dart';
import 'package:salesman/core/hive/models/active_features_model.dart';

class MenuRepository {
  final _activeFeaturesBox = Boxes.activeFeaturesBox();

  Future<ActiveFeaturesModel?> getActiveFeatures() async {
    final response = _activeFeaturesBox;
    if (response.isNotEmpty) {
      return response.values.first;
    }
    return null;
  }

  Future<bool?> setActiveFeatures(ActiveFeaturesModel activeFeatures) async {
    await _activeFeaturesBox.put(0, activeFeatures);
    return true;
  }

  Future<bool?> addActiveFeatures(ActiveFeaturesModel toBeAddedFeatures) async {
    await _activeFeaturesBox.add(toBeAddedFeatures);
    return true;
  }

  Future<bool?> deleteAllActiveFeatures() async {
    await _activeFeaturesBox.clear();
    return true;
  }
}
