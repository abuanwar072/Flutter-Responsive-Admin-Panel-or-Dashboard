import 'dart:convert';

import 'package:admin/services/firebase_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MoralisAPI {
  static String apiKey = 'pBg33FdRMQ1T1Iig3QxYumap0NbScrs8l870lx6IEqrQEX90gR8QfxhnwjKVp746';
  static String baseURL = 'https://deep-index.moralis.io/api/v2';

  static Map<String, String> headers = {
    'X-API-Key': apiKey,
    'accept': 'application/json',
  };

  static Future getBalance(String address, String chain) async {
    var url = Uri.parse('$baseURL/$address/erc20?chain=$chain');

    var response = await http.get(
      url,
      headers: headers,
    );

    double totalUSD = 0;

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      for (var token in data) {
        int decimals = token['decimals'] ?? 18;
        BigInt balance = BigInt.tryParse(token['balance']) ?? BigInt.zero;
        String address = token['token_address'];

        double price = await getPrice(address, chain);

        totalUSD += (balance / BigInt.from(10).pow(decimals)) * price;
      }

      return totalUSD;

      // print("Total Funded: ${format.format(totalUSD)}");
    } else {
      return null;
    }
  }

  static Future<double> getPrice(String contractAddress, String chain) async {
    if (FirebaseManager.tokenPrices != null) {
      if (FirebaseManager.tokenPrices![chain] != null) {
        if (FirebaseManager.tokenPrices![chain]![contractAddress] != null) {
          return FirebaseManager.tokenPrices![chain]![contractAddress]['usdPrice'] ?? 0;
        }
      }
    }

    var url = Uri.parse('$baseURL/erc20/$contractAddress/price?chain=$chain');

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      FirebaseManager.saveTokenPrice(contractAddress, data, chain);
      return data['usdPrice'] ?? 0;
    } else {
      return 0;
    }
  }
}
