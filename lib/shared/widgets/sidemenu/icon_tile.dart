import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTile extends StatefulWidget {
  const IconTile({
    super.key,
    this.activeIconSrc,
    this.inactiveIconSrc,
    required this.onPressed,
    this.isActive = false,
    this.isSubmenu = false,
  });

  final String? inactiveIconSrc, activeIconSrc;
  final VoidCallback onPressed;
  final bool isActive, isSubmenu;

  @override
  State<IconTile> createState() => _IconTileState();
}

class _IconTileState extends State<IconTile> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(AppDefaults.padding * 0.25),
        decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.highlightLight
                : _isHover
                    ? AppColors.highlightLight.withOpacity(0.5)
                    : null,
            borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: AppColors.highlightLight.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]
                : null),
        child: widget.activeIconSrc != null
            ? Center(
                child: SvgPicture.asset(
                  (widget.isActive || widget.inactiveIconSrc == null)
                      ? widget.activeIconSrc!
                      : widget.inactiveIconSrc!,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                      widget.isActive
                          ? Theme.of(context).iconTheme.color!
                          : Theme.of(context).textTheme.bodyMedium!.color!,
                      BlendMode.srcIn),
                ),
              )
            : null,
      ),
    );
  }
}
