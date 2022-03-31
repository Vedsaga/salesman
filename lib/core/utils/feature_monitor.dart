// project imports:
import 'package:salesman/core/db/hive/models/active_features_model.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';

class FeatureMonitor {
  final MenuRepository menuRepository;

  FeatureMonitor({required this.menuRepository});

  void enableFeature(
    String featureName,
  ) async {
    final _featuresMap = await menuRepository.getFeatureMap();
    if (_featuresMap != null) {
      if (_featuresMap.containsKey(featureName)) {
        _featuresMap[featureName] = false;
        await menuRepository.setActiveFeatures(
          ActiveFeaturesModel(
            disableDetails: _featuresMap['disableDetails'],
            disableClient: _featuresMap['disableClient'],
            disableItem: _featuresMap['disableItem'],
            disableTrade: _featuresMap['disableTrade'],
            disableOrder: _featuresMap['disableOrder'],
            disableDelivery: _featuresMap['disableDelivery'],
            disableReturn: _featuresMap['disableReturn'],
            disableRecords: _featuresMap['disableRecords'],
            disablePayment: _featuresMap['disablePayment'],
            disableReceive: _featuresMap['disableReceive'],
            disableHistory: _featuresMap['disableHistory'],
            disableReport: _featuresMap['disableReport'],
            disableSurvey: _featuresMap['disableSurvey'],
            disableStats: _featuresMap['disableStats'],
          ),
        );
      }
    }
  }
}
