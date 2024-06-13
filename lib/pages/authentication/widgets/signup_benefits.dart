import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';

import 'benefit_text.dart';

class SignupBenefits extends StatelessWidget {
  const SignupBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/illustration/signup_illustration.png',
          ),
        ),
        gapH24,
        gapH8,
        const Padding(
          padding: EdgeInsets.only(left: AppDefaults.padding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BenefitText(title: 'Plan includes', isTitle: true),
              gapH24,
              BenefitText(title: 'Unlimited product uploads'),
              BenefitText(title: 'Pro tips'),
              BenefitText(title: 'Free forever'),
              BenefitText(title: 'Full author options'),
            ],
          ),
        )
      ],
    );
  }
}
