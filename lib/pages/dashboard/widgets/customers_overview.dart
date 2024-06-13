import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/widgets/avatar/customer_avaatar.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/ghaps.dart';

class CoustomersOverview extends StatelessWidget {
  const CoustomersOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: "Welcome ",
                  children: [
                    TextSpan(
                      text: "857 customers",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: " with a \npersonal message 😎")
                  ],
                ),
              ),
            ),
            gapW16,
            OutlinedButton(
              onPressed: () {},
              child: Text(
                Responsive.isMobile(context) ? 'Send' : "Send message",
              ),
            ),
          ],
        ),
        gapH24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomerAvatar(
              name: "John Doe",
              imageSrc:
                  "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
              onPressed: () {},
            ),
            CustomerAvatar(
              name: "Elbert",
              imageSrc:
                  "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg",
              onPressed: () {},
            ),
            if (!Responsive.isMobile(context))
              CustomerAvatar(
                name: "Joyce",
                imageSrc:
                    "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg",
                onPressed: () {},
              ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(64, 64),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.arrow_forward_outlined),
                ),
                gapH8,
                const Text("View all"),
              ],
            )
          ],
        ),
        gapH24,
      ],
    );
  }
}
