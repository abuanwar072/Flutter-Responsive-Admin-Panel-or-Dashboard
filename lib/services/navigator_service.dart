import 'dart:io';

import 'package:yupcity_admin/models/user.dart';
import 'package:yupcity_admin/services/fade_named_page_transition.dart';
// import 'package:file_saver/file_saver.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

class NavigationService {

  String _currentPage = "";

  String get currentPage => _currentPage;

  set currentPage(String currentPage) {
    _currentPage = currentPage;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey appKey = GlobalKey();

  static String initialRoute = "/";

  static String dashBoardPage = "dashbboardPage";

  static String loginPage = "loginPage";

  static String registerPage = "registerPage";

  static String activatePage = "activatePage";

  static String recoverPage = "recoverPage";

  static String profilePage = "profilePage";

  static String settingsPage = "settingsPage";

  static String sharePage = "sharePage";

  static String howToUsePage = "howToUsePage";

  static String onBoardingPage = "onBoardingPage";

  static String checkOtpPage = "checkOtpPage";

  static String myAccountPage = "myAccountPage";

  void navigateWithoutReplacementTo(String routeName) {
    currentPage = routeName;
    navigatorKey.currentState?.pushNamed(routeName);
  }


  void navigateTo(String routeName) {
    currentPage = routeName;
    Navigator.pushReplacement(
      navigatorKey.currentContext as BuildContext,
      FadeNamedPageTransition(
        appKey,
        routeName,
      ),
    );
    // navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void navigatePop() {
    currentPage = "";
    navigatorKey.currentState?.pop();
  }

  void navigateToWithParams(String routeName, Object? params) async {
    currentPage = routeName;
    await navigatorKey.currentState?.pushReplacementNamed(
        routeName, arguments: params);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/contact.vcf');
  }


  Future<File> _createFile(String data) async {
    final file = await _localFile;
    print("Data: $data");
    return file.writeAsString('$data');
  }

  void navigateToWeb(String url) {
    _launchURL(url);
  }

  void launchURLUser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,forceSafariVC:true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url,forceSafariVC:false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}