// fluter import
import 'package:flutter/material.dart';

// third party imports:
import 'package:hive_flutter/hive_flutter.dart';

// project import
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/config/routes/router.dart';
import 'package:salesman/core/db/drift/app_database.dart';
import 'package:salesman/core/db/hive/models/active_features_model.dart';
import 'package:salesman/core/db/hive/models/agent_profile_model.dart';
import 'package:salesman/core/db/hive/models/company_profile_model.dart';

AppDatabase appDatabaseInstance = AppDatabase();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AgentProfileModelAdapter());
  await Hive.openBox<AgentProfileModel>('agent_profile');

  Hive.registerAdapter(CompanyProfileModelAdapter());
  await Hive.openBox<CompanyProfileModel>('company_profile');

  Hive.registerAdapter(ActiveFeaturesModelAdapter());
  await Hive.openBox<ActiveFeaturesModel>('active_features');

  runApp(SalemanApp());
}

class SalemanApp extends StatelessWidget {
  SalemanApp({Key? key}) : super(key: key);
  final AppRouter _router = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salesman',
      theme: AppTheme.of(context),
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}
