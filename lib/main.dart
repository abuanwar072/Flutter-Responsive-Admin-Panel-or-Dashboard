import 'package:yupcity_admin/constants.dart';
import 'package:yupcity_admin/controllers/MenuController.dart';
import 'package:yupcity_admin/screens/login_page.dart';
import 'package:yupcity_admin/screens/main/main_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:yupcity_admin/services/local_storage_service.dart';
import 'package:yupcity_admin/services/login_service.dart';
import 'package:yupcity_admin/services/navigator_service.dart';

import 'services/http_client.dart';

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
        child:  FutureBuilder<bool>(
            future: LoginService.CheckLogin(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return LoginScreenPage();
              }

              if (snapshot.data ?? false)
              {
                return  LoginScreenPage();
              }
              else {
                return  MainScreen();
              }
            }),
      ),
    );
  }

}
Future setupLocator() async {
  GetIt locator = GetIt.I;
  try {

    locator.registerSingleton<EventBus>(EventBus());
    locator.registerSingleton<NavigationService>(NavigationService());
    var instance = await LocalStorageService.getInstance();
    locator.registerSingleton<EventBus>(EventBus());
    locator.registerSingleton<LocalStorageService>(instance);
    locator.registerSingleton<HttpClient>(HttpClient());

    return Future.value(true);
  } catch (e) {
    debugPrint(e.toString());
  }
}