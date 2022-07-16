import 'package:admin/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsInfoCard extends StatelessWidget {
  const DetailsInfoCard({
    Key? key,
    this.subtitle,
    this.cardColor,
    this.svgSrc,
    required this.title,
    required this.leading,
  }) : super(key: key);

  final String title;
  final String? svgSrc;
  final Widget? subtitle;
  final Widget leading;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: cardColor != null
              ? cardColor!.withOpacity(0.15)
              : primaryColor.withOpacity(0.15),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          if (svgSrc != null)
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                svgSrc!,
                color: cardColor ?? primaryColor,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
          ),
          leading,
        ],
      ),
    );
  }
}
