// third party imports:
import 'package:hive/hive.dart';


// project imports:
import 'package:salesman/core/hive/models/agent_profile_model.dart';
import 'package:salesman/core/hive/models/company_profile_model.dart';
import 'package:salesman/core/hive/models/active_features_model.dart';

class Boxes {
  static Box<AgentProfileModel> agentProfileBox() =>
      Hive.box<AgentProfileModel>('agent_profile');
  static Box<CompanyProfileModel> companyProfileBox() =>
      Hive.box<CompanyProfileModel>('company_profile');
  static Box<ActiveFeaturesModel> activeFeaturesBox() =>
      Hive.box<ActiveFeaturesModel>('active_features');
}