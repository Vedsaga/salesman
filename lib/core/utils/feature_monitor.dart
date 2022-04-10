
// Project imports:
import 'package:salesman/core/db/hive/models/active_features_model.dart';
import 'package:salesman/modules/menu/repositories/menu_repository.dart';

class FeatureMonitor {
  final MenuRepository menuRepository;

  FeatureMonitor({required this.menuRepository});

  Future<void> enableFeature(
    String featureName,
  ) async {
    final featuresMap = await menuRepository.getFeatureMap();
    if (featuresMap != null) {
      if (featuresMap.containsKey(featureName)) {
        featuresMap[featureName] = false;
        await menuRepository.setActiveFeatures(
          ActiveFeaturesModel(
            disableDetails: featuresMap['disableDetails'] ?? false,
            disableClient: featuresMap['disableClient'] ?? false,
            disableItem: featuresMap['disableItem'] ?? true,
            disableTrade: featuresMap['disableTrade'] ?? true,
            disableOrder: featuresMap['disableOrder'] ?? true,
            disableDelivery: featuresMap['disableDelivery'] ?? true,
            disableReturn: featuresMap['disableReturn'] ?? true,
            disableRecords: featuresMap['disableRecords'] ?? true,
            disablePayment: featuresMap['disablePayment'] ?? true,
            disableReceive: featuresMap['disableReceive'] ?? true,
            disableHistory: featuresMap['disableHistory'] ?? true,
            disableReport: featuresMap['disableReport'] ?? true,
            disableSurvey: featuresMap['disableSurvey'] ?? true,
            disableStats: featuresMap['disableStats'] ?? true,
            disableSend: featuresMap['disableSend'] ?? true,
          ),
        );
      }
    }
  }

  Future<void> disableFeature(
    String featureName,
  ) async {
    final featuresMap = await menuRepository.getFeatureMap();
    if (featuresMap != null) {
      if (featuresMap.containsKey(featureName)) {
        featuresMap[featureName] = true;
        await menuRepository.setActiveFeatures(
          ActiveFeaturesModel(
            disableDetails: featuresMap['disableDetails'] ?? false,
            disableClient: featuresMap['disableClient'] ?? false,
            disableItem: featuresMap['disableItem'] ?? false,
            disableTrade: featuresMap['disableTrade'] ?? false,
            disableOrder: featuresMap['disableOrder'] ?? false,
            disableDelivery: featuresMap['disableDelivery'] ?? false,
            disableReturn: featuresMap['disableReturn'] ?? false,
            disableRecords: featuresMap['disableRecords'] ?? false,
            disablePayment: featuresMap['disablePayment'] ?? false,
            disableReceive: featuresMap['disableReceive'] ?? false,
            disableHistory: featuresMap['disableHistory'] ?? false,
            disableReport: featuresMap['disableReport'] ?? false,
            disableSurvey: featuresMap['disableSurvey'] ?? false,
            disableStats: featuresMap['disableStats'] ?? false,
            disableSend: featuresMap['disableSend'] ?? false,
          ),
        );
      }
    }
  }
}
