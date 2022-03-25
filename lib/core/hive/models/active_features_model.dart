// third part imports:
import 'package:hive/hive.dart';

// project imports

// part
part 'active_features_model.g.dart';

@HiveType(typeId: 3)
class ActiveFeaturesModel extends HiveObject {
  @HiveField(0)
  bool disableDetails;
  @HiveField(1)
  bool disableClient;
  @HiveField(2)
  bool disableItem;
  @HiveField(3)
  bool disableTrade;
  @HiveField(4)
  bool disableOrder;
  @HiveField(5)
  bool disableDelivery;
  @HiveField(6)
  bool disableReturn;
  @HiveField(7)
  bool disableRecords;
  @HiveField(8)
  bool disablePayment;
  @HiveField(9)
  bool disableReceive;
  @HiveField(10)
  bool disableHistory;
  @HiveField(11)
  bool disableReport;
  @HiveField(12)
  bool disableSurvey;
  @HiveField(13)
  bool disableStats;

  ActiveFeaturesModel({
    this.disableDetails = true,
    this.disableClient = true,
    this.disableItem = true,
    this.disableTrade = true,
    this.disableOrder = true,
    this.disableDelivery = true,
    this.disableReturn = true,
    this.disableRecords = true,
    this.disablePayment = true,
    this.disableReceive = true,
    this.disableHistory = true,
    this.disableReport = true,
    this.disableSurvey = true,
    this.disableStats = true,
  });
}
