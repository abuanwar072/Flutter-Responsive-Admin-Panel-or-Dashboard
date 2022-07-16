import 'package:admin/config/constants.dart';
import 'package:flutter/material.dart';

class TitleIconButton extends StatelessWidget {
  const TitleIconButton({
    Key? key,
    this.onPressed,
    required this.title,
    required this.icon,
    this.iconSize,
    this.titleStyle,
    this.contentColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final IconData icon;
  final double? iconSize;
  final TextStyle? titleStyle;
  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    return _DataCard(
      onPressed: onPressed,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize ?? 40,
              color: contentColor ?? Colors.black.withOpacity(0.5),
            ),
            const SizedBox(height: defaultPadding * 0.5),
            Text(
              title,
              style: titleStyle?.copyWith(color: contentColor) ??
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: contentColor ?? Colors.black.withOpacity(0.50)),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 0.5,
              horizontal: defaultPadding,
            ),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
