import 'package:admin/models/chain.dart';
import 'package:admin/services/relief_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<PieChartSectionData> paiChartSelectionDatas = [];

  @override
  void initState() {
    super.initState();
    ReliefProvider provider = context.read<ReliefProvider>();

    paiChartSelectionDatas = provider.accounts.map((e) {
      return PieChartSectionData(
        color: e.chain.color,
        value: e.totalDonations!.toDouble(),
        showTitle: false,
        radius: 25,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    ReliefProvider provider = context.watch<ReliefProvider>();

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  NumberFormat.compactSimpleCurrency(name: 'USD', decimalDigits: 2).format(provider.totalRaised),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
