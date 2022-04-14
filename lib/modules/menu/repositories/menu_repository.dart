// Project imports:
import 'package:salesman/core/db/hive/boxes.dart';
import 'package:salesman/core/db/hive/models/active_features_model.dart';

class MenuRepository {
  final _activeFeaturesBox = activeFeaturesBox();

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

  Future<Map<String, bool>?> getFeatureMap() async {
    final response = await getActiveFeatures();
    if (response != null) {
      return response.toMap();
    }
    return null;
  }
}
