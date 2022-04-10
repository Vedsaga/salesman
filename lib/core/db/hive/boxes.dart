// third party imports:

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:salesman/core/db/hive/models/active_features_model.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/db/hive/models/company_profile_model.dart';

// project imports:

Box<AgentProfileModel> agentProfileBox() =>
      Hive.box<AgentProfileModel>('agent_profile');
Box<CompanyProfileModel> companyProfileBox() =>
      Hive.box<CompanyProfileModel>('company_profile');
Box<ActiveFeaturesModel> activeFeaturesBox() =>
      Hive.box<ActiveFeaturesModel>('active_features');
