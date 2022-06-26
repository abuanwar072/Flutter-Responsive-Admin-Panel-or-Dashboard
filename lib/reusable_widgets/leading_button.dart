import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({
    Key? key,
    this.onPressed,
    this.icon,
    this.bgColor,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Ink(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Icon(
          icon,
          color: Colors.black54,
          size: 20,
        ),
      ),
    );
  }
}
