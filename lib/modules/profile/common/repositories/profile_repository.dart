// project imports:
import 'package:hive/hive.dart';
import 'package:salesman/core/hive/boxes.dart';

// project imports:
import 'package:salesman/modules/profile/common/model/agent_profile.dart';
import 'package:salesman/modules/profile/common/model/company_profile.dart';


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
  Future<bool?> editAgentProfile({
    required String name,
    required String phone,
    required String username,
  }) async {
    final agentProfile = _agentProfileBox.get(0);
    if (agentProfile != null) {
      agentProfile.name = name;
      agentProfile.phone = phone;
      agentProfile.username = username;
      agentProfile.lastUpdated = DateTime.now();
      await _agentProfileBox.put(0, agentProfile);
      return true;
    }
    return null;
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

  // make a stream that emits agent profile
  Stream<BoxEvent> getAgentProfileStream() {
    return _agentProfileBox.watch();
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
  Future<bool?> editCompanyProfile({required String name}) async {
    final companyProfile = _companyProfileBox.get(0);
    if (companyProfile != null) {
      companyProfile.name = name;
      companyProfile.lastUpdated = DateTime.now();
      await _companyProfileBox.put(0, companyProfile);
      return true;
    }
    return null;
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

  // make a stream that emits company profile
  Stream<BoxEvent> getCompanyProfileStream() {
    return _companyProfileBox.watch();
  }
}
