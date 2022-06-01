import 'package:admin/constants.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/reusable_widgets/reusable_widgets.dart';
import 'package:admin/screens/screens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmployeesDetailsScreen extends StatelessWidget {
  const EmployeesDetailsScreen({Key? key}) : super(key: key);

  static String routeName() => '/employee_details';

  @override
  Widget build(BuildContext context) {
    final Employee employee =
        ModalRoute.of(context)!.settings.arguments as Employee;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          employee.firstName! + ' ' + employee.lastName!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashRadius: 20,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddEditEmployeeScreen.routeName(),
                arguments: {
                  'isInAddMode': false,
                  'employee': employee,
                },
              );
            },
            icon: Icon(
              Icons.edit_note_rounded,
              color: Colors.black,
            ),
            splashRadius: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataCard(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    backgroundColor: Colors.transparent,
                    radius: 50,
                  ),
                  SizedBox(height: defaultPadding),
                  Text(
                    '${employee.firstName!} ${employee.lastName!}',
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(height: defaultPadding * 0.5),
                  Text(
                    '${tr('personal_id')} : ${employee.empId}',
                  ),
                  SizedBox(height: defaultPadding * 0.25),
                  Text(
                    employee.isAdmin! ? tr('admin_role') : tr('employee_role'),
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('personal_information'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('first_name'),
                    trailing: employee.firstName!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('last_name'),
                    trailing: employee.lastName!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('phone_number'),
                    trailing: employee.phoneNumber!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('email'),
                    trailing: employee.email!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('work_start_date'),
                    trailing: employee.startDate!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  if (employee.endDate != null)
                    InformationRow(
                      leading: tr('work_end_date'),
                      trailing: employee.endDate!,
                    ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('address'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('state'),
                    trailing: employee.state!,
                  ),
                  SizedBox(height: defaultPadding * 0.75),
                  InformationRow(
                    leading: tr('city'),
                    trailing: employee.cityName!,
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('official_docs'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('resume'),
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      TextButton(
                        onPressed: () {
                          // todo: impelement downloading the resume to user's device
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: primaryColor),
                        child: Text(
                          tr('download'),
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
