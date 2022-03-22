// third party imports:
import 'package:hive/hive.dart';

// generated file:
part "company_profile.g.dart" ;

@HiveType(typeId: 1)
class CompanyProfile extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final DateTime lastUpdated;
  @HiveField(2)
  final DateTime createdAt;

  CompanyProfile({
    required this.name,
    required this.lastUpdated,
    required this.createdAt,
  });
}