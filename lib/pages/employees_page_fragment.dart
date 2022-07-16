import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/controllers/employees/employees_bloc.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/search_field.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

class EmployeesPageFragment extends StatelessWidget with DialogProvider {
  static String routeName() => '/employees_page';

  EmployeesPageFragment({
    Key? key,
  }) : super(key: key);

  // CONTAINS SEARCH QUERY FOR FILTERING EMPLOYEES
  final ValueNotifier<String?> searchQuery = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    // INITIALIZE TOAST
    ToastContext().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomAppBar(
          leading: LeadingIcon(
            onPressed: () {
              // Add new employee
              Navigator.pushNamed(
                context,
                AddEditEmployeeScreen.routeName(),
                arguments: {'isInAddMode': true},
              );
            },
            icon: Icons.add_rounded,
          ),
        ),
        const SizedBox(height: defaultPadding),
        SearchField(
          onSearch: (String? query) {
            searchQuery.value = query;
          },
        ),
        const SizedBox(height: defaultPadding * 0.5),
        RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          color: primaryColor,
          onRefresh: () async {
            // CLEAR SEARCH QUERY
            searchQuery.value = null;

            // CALL GET EMPLOYEES BLOC EVENT
            BlocProvider.of<EmployeesBloc>(context).add(GetEmployees());
          },
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SlidableAutoCloseBehavior(
                  child: BlocConsumer<EmployeesBloc, EmployeesState>(
                    listener: (context, state) {
                      // IF STATE IS LOADING SHOW LOADING DIALOGUE OTHERWISE HIDE IT.
                      if (state is EmployeesLoading) {
                        showLoadingDialoge(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is EmployeesLoading) {
                        return const SizedBox();
                      }

                      if (state is EmployeesFailure) {
                        return UnexpectedErrorWidget(
                          onRetryPressed: () {
                            BlocProvider.of<EmployeesBloc>(context)
                                .add(GetEmployees());
                          },
                        );
                      }

                      if (state is EmployeesLoaded) {
                        // IF LIST OF EMPLOYEES IS EMPTY SHOW A SVG WITH TEST BELOW IT
                        if (state.employees.isEmpty) {
                          return NoDataWidget(
                            onRefreshPressed: () {
                              BlocProvider.of<EmployeesBloc>(context)
                                  .add(GetEmployees());
                            },
                            message: tr('no_employees'),
                          );
                        }

                        return ValueListenableBuilder<String?>(
                          valueListenable: searchQuery,
                          builder: (context, query, _) {
                            final employees = query == null
                                ? state.employees
                                : state.employees.where((element) {
                                    return element.firstName!.contains(query) ||
                                        element.lastName!.contains(query) ||
                                        element.email!.contains(query) ||
                                        element.phoneNumber!.contains(query) ||
                                        element.cityAr!.contains(query) ||
                                        element.cityEn!.contains(query) ||
                                        element.stateAr!.contains(query) ||
                                        element.stateEn!.contains(query);
                                  }).toList();
                            return ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                EmployeesSummary(
                                  totalEmployees: employees
                                      .where(
                                          (element) => element.endDate == null)
                                      .length,
                                  totalAdmins: employees
                                      .where((element) =>
                                          element.isAdmin! &&
                                          element.endDate == null)
                                      .length,
                                ),
                                const SizedBox(height: defaultPadding * 0.5),
                                for (int i = 0; i < employees.length; i++)
                                  EmployeeCard(
                                    onDelete: () {
                                      BlocProvider.of<EmployeesBloc>(context)
                                          .add(
                                        DeleteEmployee(
                                          employee: employees[i],
                                        ),
                                      );
                                    },
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        EmployeesDetailsScreen.routeName(),
                                        arguments: employees[i],
                                      );
                                    },
                                    employee: employees[i],
                                  ),
                              ],
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
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
    required this.onDelete,
  }) : super(key: key);

  final Employee employee;
  final VoidCallback onPressed;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    Helper.logger.e('EmployeeCard: ${employee.isAdmin}');
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            const SizedBox(width: 4),
            SlidableAction(
              autoClose: true,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.red,
              foregroundColor: secondaryColor,
              icon: Icons.delete,
              label: tr('terminate'),
              onPressed: employee.endDate != null
                  ? (context) {
                      // THE EMPLOYEE HAS BEEN ALREADY TERMINATED TOAST SHOW
                      Toast.show(
                        tr('employee_has_been_terminated'),
                      );
                    }
                  : (context) {
                      // todo: perform service termination for the employee
                      onDelete();
                    },
            ),
          ],
        ),
        child: _DataCard(
          onPressed: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InformationRow(
                leading: tr('personal_id'),
                leadingColor: primaryColor,
                trailingWidget: Row(
                  children: [
                    if (employee.endDate == null)
                      const Icon(
                        Icons.verified_user_outlined,
                        color: primaryColor,
                      ),
                    const SizedBox(width: defaultPadding * 0.5),
                    Text(
                      employee.empId.toString(),
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),
              _InfoRow(
                leading: tr('full_name'),
                trailing: '${employee.firstName!} ${employee.lastName!}',
              ),
              const SizedBox(height: defaultPadding * 0.5),
              _InfoRow(
                leading: tr('role'),
                trailing:
                    employee.isAdmin! ? tr('admin_role') : tr('employee_role'),
              ),
            ],
          ),
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
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
                const Text(
                  'total_employees_num',
                  style: TextStyle(color: primaryColor),
                ).tr(),
                const Text(
                  'employee',
                  style: TextStyle(color: primaryColor),
                ).plural(totalEmployees)
              ],
            ),
          ),
          const SizedBox(height: defaultPadding * 0.5),
          _DataCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('total_admins_num',
                        style: TextStyle(color: primaryColor))
                    .tr(),
                const Text('admin', style: TextStyle(color: primaryColor))
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
