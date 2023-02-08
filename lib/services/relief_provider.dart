import 'package:admin/models/AccounInfo.dart';
import 'package:admin/models/chain.dart';
import 'package:admin/services/firebase_manager.dart';
import 'package:admin/services/moralis_api.dart';
import 'package:flutter/material.dart';

class ReliefProvider with ChangeNotifier {
  ReliefProvider() {
    setTotalRaised();
    FirebaseManager.getTokenPrices().then((value) {
      getBalances();
    });
  }

  void getBalances() async {
    for (var account in accounts) {
      account.totalAmountUSD = await MoralisAPI.getBalance(
        account.address!,
        account.chain.shortName,
      );

      setTotalRaised();

      notifyListeners();
    }
  }

  List<AccountInfo> accounts = [
    AccountInfo(
      chain: Chain.ethereum,
      totalDonations: 1328,
      address: '0xe1935271D1993434A1a59fE08f24891Dc5F398Cd',
      totalAmount: 0,
      totalAmountUSD: 0,
    ),
    AccountInfo(
      chain: Chain.binance,
      totalDonations: 1328,
      address: '0xB67705398fEd380a1CE02e77095fed64f8aCe463',
      totalAmount: 0,
      totalAmountUSD: 0,
    ),
    AccountInfo(
      chain: Chain.avalanche,
      totalDonations: 1328,
      address: '0x868D27c361682462536DfE361f2e20B3A6f4dDD8',
      totalAmount: 0,
      totalAmountUSD: 0,
    ),
  ];

  double totalRaised = 0;

  void setTotalRaised() {
    totalRaised = accounts.fold(0, (previousValue, element) => previousValue + element.totalAmountUSD);
    notifyListeners();
  }
}
