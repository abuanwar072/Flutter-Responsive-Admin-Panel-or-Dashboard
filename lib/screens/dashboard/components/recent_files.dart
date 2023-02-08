import 'package:admin/models/RecentDonaiton.dart';
import 'package:admin/models/chain.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class RecentDonations extends StatelessWidget {
  const RecentDonations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Donations",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 530,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Donor"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Amount"),
                ),
              ],
              rows: List.generate(
                demoRecentDonations.length,
                (index) => recentFileDataRow(demoRecentDonations[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentDonation fileInfo) {
  String hideAddress(String address) {
    return address.substring(0, 6) + '...' + address.substring(address.length - 4, address.length);
  }

  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding * 0.6),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                fileInfo.chain.icon,

                // color: info.color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(hideAddress(fileInfo.donor!)),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.link))
          ],
        ),
      ),
      DataCell(
        Text(fileInfo.date.toString()),
      ),
      DataCell(
        Text(
          fileInfo.amount.toString() + ' ' + fileInfo.chain.symbol,
        ),
      ),
    ],
  );
}
