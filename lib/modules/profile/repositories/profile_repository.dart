// project imports:
import 'package:salesman/core/hive/boxes.dart';

// project imports:
import 'package:salesman/modules/profile/model/agent_profile.dart';
import 'package:salesman/modules/profile/model/company_profile.dart';

class ProfileRepository {
  final _agentProfileBox = Boxes.agentProfileBox();
  final _companyProfileBox = Boxes.companyProfileBox();

  // add agent profile
  Future<bool?> addAgentProfile(
      {required String name,
      required String phone,
      required String username,
      required DateTime lastUpdated,
      required DateTime createdAt}) async {
    final agentProfile = AgentProfile(
        name: name,
        phone: phone,
        username: username,
        lastUpdated: lastUpdated,
        createdAt: createdAt);

    await _agentProfileBox.add(agentProfile);
    return true;
  }

  // edit agent profile
  Future<void> editAgentProfile(AgentProfile agentProfile) async {
    await _agentProfileBox.putAt(0, agentProfile);
  }

  // delete agent profile
  Future<void> deleteAgentProfile() async {
    await _agentProfileBox.clear();
  }

  // get agent profile
  Future<AgentProfile?> getAgentProfile() async {
    final response = _agentProfileBox;
    if (response.isNotEmpty) {
      return response.getAt(0);
    }
    return null;
  }

  // add company profile
  Future<bool?> addCompanyProfile(
      {required String name,
      required DateTime lastUpdated,
      required DateTime createdAt}) async {
    final companyProfile = CompanyProfile(
        name: name, lastUpdated: lastUpdated, createdAt: createdAt);
    await _companyProfileBox.add(companyProfile);
    return true;
  }

  // edit company profile
  Future<void> editCompanyProfile(CompanyProfile companyProfile) async {
    await _companyProfileBox.putAt(0, companyProfile);
  }

  // delete company profile
  Future<void> deleteCompanyProfile() async {
    // delete all company profile
    await _companyProfileBox.clear();
  }

  // get company profile
  Future<CompanyProfile?>? getCompanyProfile() async {
    final response = _companyProfileBox;
    if (response.isNotEmpty) {
      return response.getAt(0);
    }
    return null;
  }
}
