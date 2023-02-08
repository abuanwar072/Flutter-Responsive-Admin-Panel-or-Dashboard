import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class AccountInfo {
  final String? svgSrc, chain, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  AccountInfo({
    this.svgSrc,
    this.chain,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  AccountInfo(
    chain: "Ethereum",
    numOfFiles: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  AccountInfo(
    chain: "BNB Smart Chain",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  AccountInfo(
    chain: "Avalanche AVAX",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  AccountInfo(
    chain: "Documents",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
