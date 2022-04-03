import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, route;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.route,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Usuarios",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_profile.svg",
    route: "users",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Cantidad de usos",
    numOfFiles: 1328,
    svgSrc: "assets/icons/key.svg",
    route: "users",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Traps",
    numOfFiles: 5328,
    svgSrc: "assets/icons/scooter.svg",
    route: "devices",
    color: Colors.blue,
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Traps ocupados",
    numOfFiles: 328,
    svgSrc: "assets/icons/lock.svg",
    route: "devices",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
