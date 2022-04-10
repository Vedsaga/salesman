// project imports:
import 'package:salesman/core/db/hive/models/active_features_model.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';

class FeatureMonitor {
  final MenuRepository menuRepository;

  FeatureMonitor({required this.menuRepository});

  void enableFeature(
    String featureName,
  ) async {
    final featuresMap = await menuRepository.getFeatureMap();
    if (featuresMap != null) {
      if (featuresMap.containsKey(featureName)) {
        featuresMap[featureName] = false;
        await menuRepository.setActiveFeatures(
          ActiveFeaturesModel(
            disableDetails: featuresMap['disableDetails'],
            disableClient: featuresMap['disableClient'],
            disableItem: featuresMap['disableItem'],
            disableTrade: featuresMap['disableTrade'],
            disableOrder: featuresMap['disableOrder'],
            disableDelivery: featuresMap['disableDelivery'],
            disableReturn: featuresMap['disableReturn'],
            disableRecords: featuresMap['disableRecords'],
            disablePayment: featuresMap['disablePayment'],
            disableReceive: featuresMap['disableReceive'],
            disableHistory: featuresMap['disableHistory'],
            disableReport: featuresMap['disableReport'],
            disableSurvey: featuresMap['disableSurvey'],
            disableStats: featuresMap['disableStats'],
            disableSend: featuresMap['disableSend'],
          ),
        );
      }
    }
  }

  void disableFeature(
    String featureName,
  ) async {
    final featuresMap = await menuRepository.getFeatureMap();
    if (featuresMap != null) {
      if (featuresMap.containsKey(featureName)) {
        featuresMap[featureName] = true;
        await menuRepository.setActiveFeatures(
          ActiveFeaturesModel(
            disableDetails: featuresMap['disableDetails'],
            disableClient: featuresMap['disableClient'],
            disableItem: featuresMap['disableItem'],
            disableTrade: featuresMap['disableTrade'],
            disableOrder: featuresMap['disableOrder'],
            disableDelivery: featuresMap['disableDelivery'],
            disableReturn: featuresMap['disableReturn'],
            disableRecords: featuresMap['disableRecords'],
            disablePayment: featuresMap['disablePayment'],
            disableReceive: featuresMap['disableReceive'],
            disableHistory: featuresMap['disableHistory'],
            disableReport: featuresMap['disableReport'],
            disableSurvey: featuresMap['disableSurvey'],
            disableStats: featuresMap['disableStats'],
            disableSend: featuresMap['disableSend'],
          ),
        );
      }
    }
  }
}
