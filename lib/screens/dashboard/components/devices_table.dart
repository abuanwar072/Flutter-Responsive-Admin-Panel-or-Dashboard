import 'package:yupcity_admin/models/Device.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class DevicesTable extends StatelessWidget {
  const DevicesTable({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Traps",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 1600,
              columns: [
                DataColumn(
                  label: Text("Lugar"),
                ),
                DataColumn(
                  label: Text("Usos total"),
                ),
                DataColumn(
                  label: Text("Nombre"),
                ),
                DataColumn(
                  label: Text("Estado"),
                ),
                DataColumn(
                  label: Text("Última revisión"),
                ),
              ],
              rows: List.generate(
                demoDevices.length,
                (index) => devicesDataRow(demoDevices[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow devicesDataRow(Device fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 15,
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.alias!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.numberOfUses!)),
      DataCell(Text(fileInfo.name!)),
      DataCell(Text(fileInfo.state!)),
      DataCell(Text(fileInfo.lastRevision!)),
    ],
  );
}
