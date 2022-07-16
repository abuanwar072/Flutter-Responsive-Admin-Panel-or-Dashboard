import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    Key? key,
    required this.leading,
    this.trailing,
    this.leadingColor,
    this.trailingWidget,
    this.isTrailingReversed = false,
  }) : super(key: key);

  final String leading;
  final String? trailing;
  final Color? leadingColor;
  final Widget? trailingWidget;
  final bool isTrailingReversed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leading,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: leadingColor),
        ),
        trailingWidget ??
            Text(
              trailing ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: (leadingColor ?? Colors.grey).withOpacity(0.9),
                    overflow: TextOverflow.ellipsis,
                  ),
              textDirection: isTrailingReversed
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
            ),
      ],
    );
  }
}
