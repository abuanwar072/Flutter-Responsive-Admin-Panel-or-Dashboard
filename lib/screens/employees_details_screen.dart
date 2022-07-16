import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/widgets.dart';
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
          '${employee.firstName!} ${employee.lastName!}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashRadius: 20,
        ),
        actions: [
          if (employee.endDate == null)
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
              icon: const Icon(
                Icons.edit_note_rounded,
                color: Colors.black,
              ),
              splashRadius: 20,
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataCard(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    backgroundColor: Colors.transparent,
                    radius: 50,
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    '${employee.firstName!} ${employee.lastName!}',
                    style: const TextStyle(color: primaryColor),
                  ),
                  const SizedBox(height: defaultPadding * 0.5),
                  Text(
                    '${tr('personal_id')} : ${employee.empId}',
                  ),
                  const SizedBox(height: defaultPadding * 0.25),
                  Text(
                    employee.isAdmin! ? tr('admin_role') : tr('employee_role'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('personal_information'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('first_name'),
                    trailing: employee.firstName!,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('last_name'),
                    trailing: employee.lastName!,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('phone_number'),
                    trailing: employee.phoneNumber!,
                    isTrailingReversed: true,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('email'),
                    trailing: employee.email!,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('work_start_date'),
                    trailing: DateFormat(Helper.isLocaleArabic(context)
                            ? 'MM/dd/yyyy'
                            : 'dd/MM/yyyy')
                        .format(DateTime.parse(employee.startDate!)),
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  if (employee.endDate != null)
                    InformationRow(
                      leading: tr('work_end_date'),
                      trailing: DateFormat(Helper.isLocaleArabic(context)
                              ? 'MM/dd/yyyy'
                              : 'dd/MM/yyyy')
                          .format(DateTime.parse(employee.endDate!)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('address'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('state'),
                    trailing: Helper.isLocaleArabic(context)
                        ? employee.stateAr!
                        : employee.stateEn!,
                  ),
                  const SizedBox(height: defaultPadding * 0.75),
                  InformationRow(
                    leading: tr('city'),
                    trailing: Helper.isLocaleArabic(context)
                        ? employee.cityAr!
                        : employee.cityEn!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('official_docs'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('resume'),
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            PDFViewerScreen.routeName(),
                            arguments: employee.cvFileUrl,
                          );
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: primaryColor),
                        child: Text(
                          tr('download'),
                          style: const TextStyle(color: secondaryColor),
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
