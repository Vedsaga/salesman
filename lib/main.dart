// fluter import
import 'package:flutter/material.dart';

// third party imports:
import 'package:hive_flutter/hive_flutter.dart';

// project import
import 'package:salesman/config/theme/theme.dart';
import 'package:salesman/config/routes/router.dart';
import 'package:salesman/modules/profile/common/model/agent_profile.dart';
import 'package:salesman/modules/profile/common/model/company_profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(AgentProfileAdapter());
  await Hive.openBox<AgentProfile>('agent_profile');

  Hive.registerAdapter(CompanyProfileAdapter());
  await Hive.openBox<CompanyProfile>('company_profile');

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
