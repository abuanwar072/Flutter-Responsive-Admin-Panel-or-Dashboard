import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/add_new_trap.dart';
import 'package:admin/screens/dashboard/components/devices_table.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'package:admin/screens/dashboard/components/header.dart';

import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';

import 'dashboard/components/user_table.dart';

class DevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(route: "devices",),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Devices",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddNewTrapScreen()),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                     // MyFiles(),
                      SizedBox(height: defaultPadding),
                      DevicesTable(),


                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
