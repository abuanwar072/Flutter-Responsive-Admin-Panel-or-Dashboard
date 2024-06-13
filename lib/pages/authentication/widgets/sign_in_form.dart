import 'package:core_dashboard/shared/constants/config.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'social_login_button.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 296,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDefaults.padding * 1.5,
            ),
            child: SvgPicture.asset(AppConfig.logo),
          ),
          Text(
            'Sign In',
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          gapH24,
          Text(
            'Sign up with Open account',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          gapH24,
          SocialLoginButton(
            onGoogleLoginPressed: () {},
            onAppleLoginPressed: () {},
          ),
          gapH24,
          const Divider(),
          gapH24,
          Text(
            'Or continue with email address',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          gapH16,
        ],
      ),
    );
  }
}
