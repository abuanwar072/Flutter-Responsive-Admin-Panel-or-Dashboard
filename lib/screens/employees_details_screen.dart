import 'package:admin/constants.dart';
import 'package:admin/models/employee.dart';
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
          style: TextStyle(color: Colors.black),
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
          splashRadius: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/add_edit_employee');
            },
            icon: Icon(
              Icons.edit_note_rounded,
              color: Colors.black,
            ),
            splashRadius: 25,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DataCard(
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
                  Text(
                    '${tr('personal_id')} : ${employee.empId}',
                  ),
                  Text(
                    employee.isAdmin! ? tr('admin_role') : tr('employee_role'),
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            _DataCard(
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
                  _InfoRow(
                    leading: tr('first_name'),
                    trailing: employee.firstName!,
                  ),
                  SizedBox(height: defaultPadding * .5),
                  _InfoRow(
                    leading: tr('last_name'),
                    trailing: employee.lastName!,
                  ),
                  SizedBox(height: defaultPadding * .5),
                  _InfoRow(
                    leading: tr('phone_number'),
                    trailing: employee.phoneNumber!,
                  ),
                  SizedBox(height: defaultPadding * .5),
                  _InfoRow(
                    leading: tr('email'),
                    trailing: employee.email!,
                  ),
                  SizedBox(height: defaultPadding * .5),
                  _InfoRow(
                    leading: tr('work_start_date'),
                    trailing: employee.startDate!,
                  ),
                  SizedBox(height: defaultPadding * .5),
                  if (employee.endDate != null)
                    _InfoRow(
                      leading: tr('work_end_date'),
                      trailing: employee.endDate!,
                    ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            _DataCard(
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
                  _InfoRow(
                    leading: tr('state'),
                    trailing: employee.state!,
                  ),
                  SizedBox(height: defaultPadding * 0.5),
                  _InfoRow(
                    leading: tr('city'),
                    trailing: employee.cityName!,
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            _DataCard(
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

class _DataCard extends StatelessWidget {
  const _DataCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding * 0.5,
        horizontal: defaultPadding,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    Key? key,
    required this.leading,
    required this.trailing,
    this.leadingColor,
  }) : super(key: key);

  final String leading;
  final String trailing;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leading,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: leadingColor),
        ),
        Text(
          trailing,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: (leadingColor ?? Colors.grey).withOpacity(0.9),
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ],
    );
  }
}
