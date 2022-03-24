// third party imports:
import 'package:hive/hive.dart';
import 'package:salesman/modules/profile/common/model/agent_profile.dart';
import 'package:salesman/modules/profile/common/model/company_profile.dart';


// project imports:


class Boxes {
  static Box<AgentProfile> agentProfileBox() => Hive.box<AgentProfile>('agent_profile');
  static Box<CompanyProfile> companyProfileBox() => Hive.box<CompanyProfile>('company_profile');
}