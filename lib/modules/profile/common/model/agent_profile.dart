// third party imports:
import 'package:hive/hive.dart';

// generated file:
part "agent_profile.g.dart" ;

@HiveType(typeId: 0)
class AgentProfile extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phone;
  @HiveField(2) 
  String username;
  @HiveField(3)
  DateTime lastUpdated;
  @HiveField(4)
  final DateTime createdAt;

  AgentProfile({
    required this.name,
    required this.phone,
    required this.username,
    required this.lastUpdated,
    required this.createdAt,
  });
}
