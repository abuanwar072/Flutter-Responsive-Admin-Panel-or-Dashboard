import 'dart:math';

import 'package:core_dashboard/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class ProductOverviews extends StatelessWidget {
  const ProductOverviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius:
            BorderRadius.all(Radius.circular(AppDefaults.borderRadius)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SectionTitle(
                title: "Product views",
                color: AppColors.secondaryLavender,
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppDefaults.borderRadius)),
                  border: Border.all(width: 2, color: AppColors.highlightLight),
                ),
                child: DropdownButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding, vertical: 0),
                  style: Theme.of(context).textTheme.labelLarge,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppDefaults.borderRadius)),
                  underline: const SizedBox(),
                  value: "Last 7 days",
                  items: const [
                    DropdownMenuItem(
                      value: "Last 7 days",
                      child: Text("Last 7 days"),
                    ),
                    DropdownMenuItem(
                      value: "All time",
                      child: Text("All time"),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          gapH24,
          const BarChartSample8(),
        ],
      ),
    );
  }
}

class BarChartSample8 extends StatefulWidget {
  const BarChartSample8({super.key});

  final Color barBackgroundColor = AppColors.bgSecondayLight;
  final Color barColor = AppColors.secondaryMintGreen;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample8> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.all(16),
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Icon(Icons.graphic_eq),
          //     const SizedBox(
          //       width: 32,
          //     ),
          //     Text(
          //       'Sales forecasting chart',
          //       style: TextStyle(
          //         color: widget.barColor,
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 32,
          // ),
          Expanded(
            child: BarChart(
              randomData(),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y,
  ) {
    return BarChartGroupData(
      x: x + 22,
      barRods: [
        BarChartRodData(
          toY: y,
          color: (x % 2 == 0)
              ? AppColors.secondaryPeach
              : (x % 3 == 0)
                  ? AppColors.primary
                  : widget.barColor,
          borderRadius: BorderRadius.circular(2),
          // borderDashArray: x >= 4 ? [4, 4] : null,
          width: Responsive.isMobile(context) ? 20 : 40,
          borderSide: BorderSide(
            color: (x % 2 == 0)
                ? AppColors.secondaryPeach
                : (x % 3 == 0)
                    ? AppColors.primary
                    : widget.barColor,
            width: 2.0,
          ),
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      // color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    Widget text = Text(
      days[value.toInt()],
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      maxY: 30.0,
      // minX: 0,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          direction: TooltipDirection.auto,
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // getTitlesWidget: getTitles,
            getTitlesWidget: (value, meta) => SideTitleWidget(
              axisSide: AxisSide.bottom,
              child: Text(value.toString()),
            ),
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 38,
            showTitles: true,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(
        7,
        (i) => makeGroupData(
          i,
          Random().nextInt(20).toDouble() + 10,
        ),
      ),
      gridData: const FlGridData(show: true, drawVerticalLine: false),
    );
  }
}
