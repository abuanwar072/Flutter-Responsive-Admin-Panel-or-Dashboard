import 'package:core_dashboard/pages/dashboard/widgets/overview.dart';
import 'package:core_dashboard/pages/dashboard/widgets/product_overview.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/ghaps.dart';
import 'widgets/comments.dart';
import 'widgets/get_more_customers.dart';
import 'widgets/popular_products.dart';
import 'widgets/pro_tips.dart';
import 'widgets/refund_request.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        Text(
          "Dashboard",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        gapH20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const Overview(),
                  gapH16,
                  const ProductOverviews(),
                  gapH16,
                  const ProTips(),
                  gapH16,
                  const GetMoreCustomers(),
                  if (Responsive.isMobile(context))
                    const Column(
                      children: [
                        gapH16,
                        PopularProducts(),
                        gapH16,
                        Comments(),
                        gapH16,
                        RefundRequest(newRefund: 8, totalRefund: 52),
                        gapH8,
                      ],
                    ),
                ],
              ),
            ),
            if (!Responsive.isMobile(context)) gapW16,
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 2,
                child: Column(
                  children: [
                    PopularProducts(),
                    gapH16,
                    Comments(),
                    gapH16,
                    RefundRequest(newRefund: 8, totalRefund: 52),
                    gapH8,
                  ],
                ),
              ),
          ],
        )
      ],
    );
  }
}
