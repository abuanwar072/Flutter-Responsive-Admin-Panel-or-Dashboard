import 'package:admin/models/AccounInfo.dart';
import 'package:admin/models/chain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.account,
  }) : super(key: key);

  final AccountInfo account;

  String hideAddress(String address) {
    return address.substring(0, 6) + '...' + address.substring(address.length - 4, address.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.6),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: account.chain.color.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(account.chain.icon

                    // color: info.color,
                    ),
              ),
              IconButton(
                onPressed: () async {
                  ClipboardData data = ClipboardData(text: account.address);
                  await Clipboard.setData(data);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${account.chain.name} address to clipboard'),
                    ),
                  );
                },
                icon: Icon(
                  Icons.copy,
                  color: Colors.white54,
                ),
              )
            ],
          ),
          Text(
            account.chain.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            hideAddress(account.address!),
            style: Theme.of(context).textTheme.overline!.copyWith(
                  color: Colors.white,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${account.totalDonations} Donations",
                style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white70),
              ),
              // Text(
              //   info.totalStorage!,
              //   style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
              // ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
