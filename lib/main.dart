import 'package:yupcity_admin/constants.dart';
import 'package:yupcity_admin/controllers/MenuController.dart';
import 'package:yupcity_admin/screens/main/main_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:event_bus/event_bus.dart';

void main() {
  runApp(MyApp());

  setupLocator();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),

      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }

}
Future setupLocator() async {
  GetIt locator = GetIt.I;
  try {

    locator.registerSingleton<EventBus>(EventBus());

    return Future.value(true);
  } catch (e) {
    debugPrint(e.toString());
  }
}