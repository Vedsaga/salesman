// third party imports:
import 'package:hive/hive.dart';

// generated file:
part "agent_profile.g.dart" ;

@HiveType(typeId: 0)
class AgentProfile extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phone;
  @HiveField(2) 
  final String username;
  @HiveField(3)
  final DateTime lastUpdated;
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
