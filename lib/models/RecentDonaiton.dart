import 'package:admin/models/chain.dart';

class RecentDonation {
  final String? donor;
  final Chain chain;
  final DateTime date;
  final double amount;

  RecentDonation({
    this.donor,
    required this.date,
    required this.amount,
    required this.chain,
  });
}

List demoRecentDonations = [
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.ethereum,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.avalanche,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.binance,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.ethereum,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.avalanche,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.binance,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.ethereum,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.avalanche,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.binance,
  ),
  RecentDonation(
    donor: "0xe1935271D1993434A1a59fE08f24891Dc5F398Cd",
    date: DateTime.now(),
    amount: 0.5,
    chain: Chain.ethereum,
  ),
];
