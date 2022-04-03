import 'package:admin/controllers/MenuController.dart';
import 'package:admin/models/events/NavigationScreen.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/devices_screen.dart';
import 'package:admin/screens/user_screen.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  //const MainScreen({ Key? key }) : super(key: key);
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  String currentScreen = "dashboard";

  @override
  void initState() {
    super.initState();

    _registerEvents();

  }

  void _registerEvents() async {

    GetIt.I.get<EventBus>().on<NavigationScreen>().listen((event) {
      if (mounted) {
        setState(() {
          currentScreen = event.routeName;
        });

      }

    });

  }

  createScreen(String routeName) {
    switch(routeName) {
      case "dashboard":
        return DashboardScreen();
      case "users":
        return UserScreen();
      case "devices":
      return DevicesScreen();

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: createScreen(currentScreen),
            ),
          ],
        ),
      ),
    );


  }


}
