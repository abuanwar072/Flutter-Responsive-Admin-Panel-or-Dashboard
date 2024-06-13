import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    this.onGoogleLoginPressed,
    this.onAppleLoginPressed,
  });

  final Function()? onGoogleLoginPressed, onAppleLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: onGoogleLoginPressed,
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/google_filled.svg'),
              gapW8,
              const Text('Google')
            ],
          ),
        ),
        gapW8,
        OutlinedButton(
          onPressed: onAppleLoginPressed,
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/apple_ic.svg'),
              gapW8,
              const Text('Apple ID')
            ],
          ),
        ),
      ],
    );
  }
}
