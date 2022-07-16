import 'package:admin/config/constants.dart';
import 'package:flutter/material.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({
    Key? key,
    this.onPressed,
    this.icon,
    this.bgColor,
    this.isHidden = false,
    this.height,
    this.width,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? bgColor;
  final bool? isHidden;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Ink(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: isHidden!
              ? Theme.of(context).scaffoldBackgroundColor
              : bgColor ?? secondaryColor,
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
