import 'package:admin/config/constants.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.child,
    this.borderRadius,
    this.bgColor,
    this.onPressed, this.splashColor,
  }) : super(key: key);

  final Widget child;
  final BorderRadius? borderRadius;
  final Color? bgColor;
  final VoidCallback? onPressed;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      splashColor: splashColor,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding * 0.5,
          horizontal: defaultPadding,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? secondaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
