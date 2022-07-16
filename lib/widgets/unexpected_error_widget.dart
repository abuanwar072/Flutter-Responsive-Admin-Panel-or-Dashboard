import 'package:admin/config/constants.dart';
import 'package:admin/widgets/try_again_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnexpectedErrorWidget extends StatelessWidget {
  const UnexpectedErrorWidget({
    Key? key,
    required this.onRetryPressed,
  }) : super(key: key);

  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 3),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/bad_request.svg',
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            Text(
              tr('unexpected_error'),
              style: const TextStyle(color: primaryColor),
            ),
            const SizedBox(height: defaultPadding * 3),
            TryAgainButton(
              onPressed: onRetryPressed,
            ),
          ],
        ),
      ),
    );
  }
}
