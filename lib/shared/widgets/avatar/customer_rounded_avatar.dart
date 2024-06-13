import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:flutter/cupertino.dart';

class CustomerRoundedAvatar extends StatelessWidget {
  const CustomerRoundedAvatar({
    super.key,
    this.height = 54,
    this.width = 54,
    this.radius = AppDefaults.borderRadius,
    required this.imageSrc,
  });

  final double height, width, radius;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: NetworkImage(imageSrc),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
