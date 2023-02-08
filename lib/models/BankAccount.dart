import 'dart:ui';

import 'package:admin/models/chain.dart';
import 'package:flutter/material.dart';

class BankAccount {
  final String organizationName;
  final String bankName;
  final String iban;
  final String currency;
  final String? swiftCode;
  final String? proof;

  BankAccount({
    required this.organizationName,
    required this.bankName,
    required this.iban,
    required this.currency,
    this.swiftCode,
    this.proof,
  });

  Color get organizationColor {
    switch (organizationName) {
      case "AHBAP":
        return Color(0xFF81B222);
      case "AFAD":
        return Color(0xFF002B6C);
      case "AFAD":
        return Color(0xFFD30D17);
      default:
        return Colors.white;
    }
  }
}

List bankAccounts = [
  BankAccount(
    organizationName: "AHBAP",
    bankName: "İş Bankası",
    iban: "TR150006400000210212150277",
    currency: "EUR",
    swiftCode: "ISBKTRIS",
    proof: "",
  ),
  BankAccount(
    organizationName: "AHBAP",
    bankName: "İş Bankası",
    iban: "TR320006400000210212150262",
    currency: "USD",
    swiftCode: "ISBKTRIS",
    proof: "",
  ),
  BankAccount(
    organizationName: "AHBAP",
    bankName: "İş Bankası",
    iban: "TR120006400000110211380059",
    currency: "TL",
    swiftCode: "",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR730001001745555555555204",
    currency: "TL",
    swiftCode: "",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR460001001745555555555205",
    currency: "USD",
    swiftCode: "TCZBTR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR190001001745555555555206",
    currency: "EUR",
    swiftCode: "TCZBTR2A",
    proof: "",
  ),
  BankAccount(
    organizationName: "AFAD",
    bankName: "T.C. ZİRAAT BANKASI A.Ş.",
    iban: "TR430001001745555555555356",
    currency: "GPB",
    swiftCode: "TCZBTR2A",
    proof: "",
  ),
];
