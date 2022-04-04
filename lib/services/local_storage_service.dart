import 'dart:convert';
import 'dart:io';

import 'package:yupcity_admin/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String UserKey = 'user';
  static const String UserDatsmiKey = 'userDatsmi';
  static const String TipKey = 'tip';
  static const String notificationKey = 'notification';
  static const String Password = "password";
  static const String theme = "theme";
  static const String themeColor = "themeColor";
  static const String token = "token";
  static const String seconds = "secondsConfigured";
  static const String call = "call";
  static const String gps = "gps";
  static const String email = "email";
  static const String avatar = "avatar";
  static const String cUserName = "cUserName";
  static const String cEmail = "cEmail";
  static const String application = "app";
  static const String onBoarding = "onBoarding";
  static const String rememberMe = "rememberMe";
  static const String language = "language";
  static const String themeImage = "themeImage";
  static const String acceptTerms = "acceptTerms";
  static const String colorsActivate = "colorsActivate";

  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  setApp(String app) {
    saveStringToDisk(application, app);
  }

  String getApp() {
    var app = getFromDisk(application);
    if (app == null) {
      return "yupcity";
    }

    return app;
  }

  setImageBackground(String image) {
    saveStringToDisk(themeImage, image);
  }

  String getImageBackground() {
    var getImageBackground = getFromDisk(themeImage);
    if (getImageBackground == null) {
      return "assets/bg/splash2.jpg";
    }

    return getImageBackground;
  }


  setColorsActivate(bool activateColors) {
    saveStringToDisk(colorsActivate, activateColors.toString());
  }


  bool getColorsActivate() {
    var colorsActivateBoolean = getFromDisk(colorsActivate);
    if (colorsActivateBoolean == null) {
      return false;
    }

    return colorsActivateBoolean == "true";
  }


  setLanguage(String isoCodeLanguage) {
    saveStringToDisk(language, isoCodeLanguage);
  }

  setThemeName(int themeData) {
    saveStringToDisk(theme, themeData.toString());
  }

  int getThemeName() {
    var themeNameGet = getFromDisk(theme);
    if (themeNameGet == null) {
      return 0;
    }

    try {
      return int.parse(themeNameGet);
    }catch(e) {
      return 0;
    }
  }

  String getLanguageCurrent() {
    var isoCode = getFromDisk(language);
    try {
      if (Platform.isIOS || Platform.isAndroid) {
        if (isoCode == null) return Platform.localeName
            .split("_")
            .first;
      }
      else {
        return "en";
      }
    }catch(e) {
      return "en";
    }
    return isoCode;
  }

  setColorTheme(int color) {
    saveStringToDisk(themeColor, color.toString());
  }

  Color getColorTheme() {
    var colorGet = getFromDisk(theme);
    switch(colorGet.toString())
    {
      case "pink": return Colors.pink;
      case "green" : return Colors.green;
      case "lightblue" : return Colors.lightBlue;
      case "blue" : return Colors.blue;
      case "purple" : return Colors.purple;
      case "purpleAccent" : return Colors.purpleAccent;
    }

    if (colorGet == null) {
      return Colors.blue;
    }

    try {
      return Color(colorGet as int);
    }
    catch(e) {
        debugPrint(e.toString());
        return Colors.white;
    }

  }

  setOnboarding(String user, DateTime dateTime) {
    saveStringToDisk(user + onBoarding, dateTime.toIso8601String());
  }

  bool getOnBoarding(String user) {
    var onBoardingData = getFromDisk(user + onBoarding);
    if (onBoardingData == null) {
      return true;
    }

    return false;
  }

  setRememberMe(bool rememberMeValue) {
    saveStringToDisk(rememberMe, rememberMeValue.toString());
  }

  bool getRememberMe() {
    var tokenData = getFromDisk(rememberMe);
    if (tokenData == null) {
      return false;
    }

    return tokenData == "true";
  }

  setTerms(String user, DateTime dateTime) {
    saveStringToDisk(user + acceptTerms, dateTime.toIso8601String());
  }

  bool getTerms(String user) {
    var terms = getFromDisk(user + acceptTerms);
    if (terms == null) {
      return false;
    }

    return true;
  }

  setSeconds(int secondsValue) {
    saveStringToDisk(seconds, secondsValue.toString());
  }

  int getSeconds() {
    var secondsValue = getFromDisk(seconds);
    if (secondsValue == null) {
      return 90;
    }

    return int.parse(secondsValue);
  }

  setCall(bool callToken) {
    saveStringToDisk(call, callToken.toString());
  }

  bool getCall() {
    var tokenData = getFromDisk(call);
    if (tokenData == null) {
      return true;
    }

    return tokenData == "true";
  }

  setUsername(String currentUsername) {
    saveStringToDisk(cUserName, currentUsername);
  }

  String getUsername() {
    var userName = getFromDisk(cUserName);
    if (userName == null) {
      return "";
    }

    return userName;
  }

  setEmail(bool emailToken) {
    saveStringToDisk(email, emailToken.toString());
  }

  setCurrentEmail(String email) {
    saveStringToDisk(cEmail, email);
  }

  String getCurrentEmail() {
    var email = getFromDisk(cEmail);
    if (email == null) {
      return "";
    }

    return email;
  }

  bool getEmail() {
    var tokenData = getFromDisk(email);
    if (tokenData == null) {
      return true;
    }

    return tokenData == "true";
  }

  setGPS(bool gpsToken) {
    saveStringToDisk(gps, gpsToken.toString());
  }

  bool getGPS() {
    var tokenData = getFromDisk(gps);
    if (tokenData == null) {
      return true;
    }

    return tokenData == "true";
  }

  YupcityUser? getUser() {
    var userJson = getFromDisk(UserDatsmiKey);
    if (userJson == null) {
      return null;
    }
    try {
      return YupcityUser.fromJson(json.decode(userJson));
    } catch (e) {
      return null;
    }
  }

  setUser(YupcityUser userToSave) {
    saveStringToDisk(UserDatsmiKey, json.encode(userToSave.toJson()));
  }

  setAvatar(String path, String userName) {
    saveStringToDisk(avatar + userName, path);
  }

  setCurrentPassword(String currentPassword) {
    saveStringToDisk(Password, currentPassword);
  }

  String getCurrentPassword() {
    var tokenData = getFromDisk(Password);
    if (tokenData == null) {
      return "";
    }
    return tokenData;
  }

  setToken(String tokenData) {
    saveStringToDisk(token, tokenData);
  }

  String getToken() {
    var tokenData = getFromDisk(token);
    if (tokenData == null) {
      return "";
    }
    return tokenData;
  }

  String getAvatar(String userName) {
    var path = getFromDisk(avatar + userName);
    if (path == null) {
      return "";
    }
    return path;
  }

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void saveStringToDisk(String key, String content) {
    _preferences.setString(key, content);
  }
}
