import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuProvider.dart';
import 'package:admin/screens/dashboard/bank_accounts.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/components/full_page.dart';
import 'package:admin/services/firebase_manager.dart';
import 'package:admin/services/relief_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseManager.init();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReliefProvider(),
          ),
        ],
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return VRouter(
      debugShowCheckedModeBanner: false,
      title: 'Turkey Earthquake Relief Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      mode: VRouterMode.history,
      transitionDuration: Duration.zero,
      routes: [
        VNester(
          path: '/',
          widgetBuilder: (child) => FullPage(child: child),
          nestedRoutes: [
            VWidget(path: '/', widget: DashboardScreen()),
            VWidget(path: 'dashboard', widget: DashboardScreen()),
            VWidget(path: 'bankaccounts', widget: BankAccountsScreen()),
          ],
        )
      ]
    );
  }
}
