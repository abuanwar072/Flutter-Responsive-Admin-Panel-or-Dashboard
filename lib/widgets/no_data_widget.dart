import 'package:admin/config/constants.dart';
import 'package:admin/widgets/try_again_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.onRefreshPressed,
    required this.message,
  }) : super(key: key);

  final VoidCallback onRefreshPressed;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 3),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/no_data.svg',
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            Text(
              message,
              style: const TextStyle(color: primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding * 3),
            TryAgainButton(
              title: tr('refresh'),
              onPressed: onRefreshPressed,
            ),
          ],
        ),
      ),
    );
  }
}
