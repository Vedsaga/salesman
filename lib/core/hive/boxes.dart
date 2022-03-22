// third party imports:
import 'package:hive/hive.dart';


// project imports:
import 'package:salesman/modules/profile/model/agent_profile.dart';
import 'package:salesman/modules/profile/model/company_profile.dart';

class Boxes {
  static Box<AgentProfile> agentProfileBox() => Hive.box<AgentProfile>('agent_profile');
  static Box<CompanyProfile> companyProfileBox() => Hive.box<CompanyProfile>('company_profile');
}