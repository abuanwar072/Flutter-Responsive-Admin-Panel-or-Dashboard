import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/config.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'widgets/signup_benefits.dart';
import 'widgets/signup_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            if (!Responsive.isMobile(context))
              Expanded(
                flex: Responsive.isTablet(context) ? 2 : 1,
                child: Container(
                  color: AppColors.bgLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// APP LOGO
                      if (!Responsive.isMobile(context))
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDefaults.padding,
                            vertical: AppDefaults.padding * 1.5,
                          ),
                          child: SvgPicture.asset(AppConfig.logo),
                        ),

                      /// SIGNUP BENEFITS
                      const Expanded(child: SignupBenefits()),
                    ],
                  ),
                ),
              ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// APP LOGO
                      Responsive.isMobile(context)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDefaults.padding,
                                vertical: AppDefaults.padding * 1.5,
                              ),
                              child: SvgPicture.asset(AppConfig.logo),
                            )
                          : const SizedBox(),

                      /// LOGIN TEXT
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDefaults.padding,
                          vertical: AppDefaults.padding * 1.5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Already a member?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textGrey),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                  color: AppColors.titleLight,
                                ),
                              ),
                              onPressed: () => context.go('/sign-in'),
                              child: const Text('Sign in'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// SIGNUP FORM
                  const Expanded(child: SignupForm()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
