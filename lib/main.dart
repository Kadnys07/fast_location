import 'package:flutter/material.dart';
import 'src/modules/history/page/history_page.dart';
import 'src/modules/home/page/home_page.dart';
import 'src/modules/initial/page/initial_page.dart';
import 'src/routes/app_routes.dart';
import 'src/shared/colors/app_colors.dart';
import 'src/shared/storage/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.init();
  runApp(const FastLocationApp());
}

class FastLocationApp extends StatelessWidget {
  const FastLocationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastLocation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialRoute: AppRoutes.initial,
      routes: {
        AppRoutes.initial: (_) => const InitialPage(),
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.history: (_) => const HistoryPage(),
      },
    );
  }
}
