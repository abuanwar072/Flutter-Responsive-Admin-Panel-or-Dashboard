import 'package:admin/constants.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/reusable_widgets/search_field.dart';
import 'package:admin/screens/employees_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class EmployeesPageFragment extends StatelessWidget {
  EmployeesPageFragment({
    Key? key,
  }) : super(key: key);
  final totalEmployees = 72;
  final totalAdmins = 3;
  final Faker faker = Faker();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SearchField(),
        SizedBox(height: defaultPadding * 0.5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.76,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              EmployeesSummary(
                totalEmployees: totalEmployees,
                totalAdmins: totalAdmins,
              ),
              SizedBox(height: defaultPadding),
              for (int i = 0; i < 72; i++)
                EmployeeCard(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      EmployeesDetailsScreen.routeName(),
                      arguments: Employee(
                        empId: i,
                        cityName: faker.address.city(),
                        state: faker.address.state(),
                        firstName: faker.person.firstName(),
                        lastName: faker.person.lastName(),
                        phoneNumber: faker.phoneNumber.us(),
                        email: faker.internet.email(),
                        cvImgUrl: faker.image.image(),
                        startDate: DateFormat('y-mm-dd').format(
                            faker.date.dateTime(minYear: 2000, maxYear: 2022)),
                        endDate: DateFormat('y-mm-dd').format(
                            faker.date.dateTime(minYear: 2000, maxYear: 2022)),
                        isAdmin: faker.randomGenerator.boolean(),
                      ),
                    );
                  },
                  employee: Employee(
                    empId: i,
                    cityName: faker.address.city(),
                    state: faker.address.state(),
                    firstName: faker.person.firstName(),
                    lastName: faker.person.lastName(),
                    phoneNumber: faker.phoneNumber.us(),
                    email: faker.internet.email(),
                    cvImgUrl: faker.image.image(),
                    startDate: faker.date.toString(),
                    isAdmin: faker.randomGenerator.boolean(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    Key? key,
    required this.employee,
    required this.onPressed,
  }) : super(key: key);

  final Employee employee;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
      child: _DataCard(
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _InfoRow(
              leading: tr('personal_id'),
              trailing: '${employee.empId!}',
              leadingColor: primaryColor,
            ),
            SizedBox(height: defaultPadding),
            _InfoRow(
              leading: tr('full_name'),
              trailing: '${employee.firstName!} ${employee.lastName!}',
            ),
            SizedBox(height: defaultPadding * 0.5),
            _InfoRow(
              leading: tr('role'),
              trailing:
                  employee.isAdmin! ? tr('admin_role') : tr('employee_role'),
            ),
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
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 0.5,
              horizontal: defaultPadding,
            ),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class EmployeesSummary extends StatelessWidget {
  const EmployeesSummary({
    Key? key,
    required this.totalEmployees,
    required this.totalAdmins,
  }) : super(key: key);
  final int totalEmployees;
  final int totalAdmins;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DataCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'total_employees_num',
                  style: TextStyle(color: primaryColor),
                ).tr(),
                Text(
                  'employee',
                  style: TextStyle(color: primaryColor),
                ).plural(totalEmployees)
              ],
            ),
          ),
          SizedBox(height: defaultPadding * 0.5),
          _DataCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total_admins_num', style: TextStyle(color: primaryColor))
                    .tr(),
                Text('admin', style: TextStyle(color: primaryColor))
                    .plural(totalAdmins)
              ],
            ),
          ),
        ],
      ),
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
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: (leadingColor ?? Colors.grey).withOpacity(0.9)),
        ),
      ],
    );
  }
}

// _DataCard(
//   child: DetailsInfoCard(
//     title: tr('total_employees_num'),
//     leading: Text('employee').plural(totalEmployees),
//     cardColor: Color(0XFFF5F5F5),
//   ),
// ),
