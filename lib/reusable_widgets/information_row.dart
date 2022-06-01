import 'package:flutter/material.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    Key? key,
    required this.leading,
    required this.trailing,
    this.leadingColor,
  }) : super(key: key);

  final String leading;
  final String trailing;
  final Color? leadingColor;

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
        Text(
          trailing,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: (leadingColor ?? Colors.grey).withOpacity(0.9),
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ],
    );
  }
}
