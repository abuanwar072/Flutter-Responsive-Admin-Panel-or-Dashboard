import 'package:core_dashboard/shared/constants/extensions.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'social_login_button.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 296,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signup',
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

              /// EMAIL FIELD
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/mail_light.svg',
                    height: 16,
                    width: 20,
                    fit: BoxFit.none,
                  ),
                  suffixIcon: SvgPicture.asset(
                    'assets/icons/check_filled.svg',
                    width: 17,
                    height: 11,
                    fit: BoxFit.none,
                    colorFilter: AppColors.success.toColorFilter,
                  ),
                  hintText: 'Your email',
                ),
              ),
              gapH16,

              /// CONTINUE BUTTON
              SizedBox(
                width: 296,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Continue'),
                ),
              ),
              gapH24,
              Text(
                'This site is protected by reCAPTCHA and the Google Privacy Policy.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
