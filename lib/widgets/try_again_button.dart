import 'package:admin/config/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({
    Key? key,
    required this.onPressed,
    this.title,
    this.titleWidget,
    this.iconSize,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String? title;
  final Widget? titleWidget;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 0.5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleWidget ??
                Text(
                  title ?? tr('try_again'),
                  style: const TextStyle(color: Colors.white),
                ),
            const SizedBox(width: defaultPadding * 0.5),
            Icon(
              Icons.loop_rounded,
              color: Colors.white,
              size: iconSize ?? 18,
            ),
          ],
        ),
      ),
    );
  }
}
