

// Package imports:
import 'package:hive/hive.dart';

// generated file:
part "company_profile_model.g.dart";

@HiveType(typeId: 1)
class CompanyProfileModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  DateTime lastUpdated;
  @HiveField(2)
  final DateTime createdAt;

  CompanyProfileModel({
    required this.name,
    required this.lastUpdated,
    required this.createdAt,
  });
}
