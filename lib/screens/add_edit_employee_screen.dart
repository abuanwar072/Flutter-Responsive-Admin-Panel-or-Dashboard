import 'package:admin/constants.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/reusable_widgets/reusable_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  static String routeName() => '/add_edit_employee';

  AddEditEmployeeScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<bool> isEmpAdmin = ValueNotifier(false);
  final ValueNotifier<String> resumeFileName = ValueNotifier('');

  final DateTime startDate = DateTime.now();

  _fillEmployeeData(Employee emp) {
    _firstNameController.text = emp.firstName!;
    _lastNameController.text = emp.lastName!;
    _phoneController.text = emp.phoneNumber!;
    _emailController.text = emp.email!;
    _stateController.text = emp.state!;
    _cityController.text = emp.cityName!;

    isEmpAdmin.value = emp.isAdmin!;
    resumeFileName.value = emp.resumeFileName!;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final Employee? emp = data['employee'];
    if (emp != null) _fillEmployeeData(emp);
    final isInAddMode = data['isInAddMode'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isInAddMode ? tr('add_emp') : tr('edit_emp'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,

        // Back Button
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
              // todo: perform update functionality
            },
            icon: Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.black,
            ),
            splashRadius: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataCard(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding * 0.5),
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
                      _buildTextFormField(
                        context: context,
                        hintText: tr('first_name'),
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        validator: (content) {
                          return null;
                        },
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                      _buildTextFormField(
                        context: context,
                        hintText: tr('last_name'),
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        validator: (content) {
                          return null;
                        },
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                      _buildTextFormField(
                        context: context,
                        hintText: tr('phone_number'),
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (content) {
                          return null;
                        },
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                      _buildTextFormField(
                        context: context,
                        hintText: tr('email'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (content) {
                          return null;
                        },
                      ),
                      if (emp == null)
                        Column(
                          children: [
                            SizedBox(height: defaultPadding * 0.5),
                            _buildTextFormField(
                              context: context,
                              hintText: tr('password'),
                              isPasswordField: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              validator: (content) {
                                return null;
                              },
                            ),
                          ],
                        ),
                      SizedBox(height: defaultPadding * 0.5)
                    ],
                  ),
                ),
              ),
              SizedBox(height: defaultPadding),
              DataCard(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding * 0.5),
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
                      _buildTextFormField(
                        context: context,
                        hintText: tr('state'),
                        controller: _stateController,
                        keyboardType: TextInputType.name,
                        validator: (content) {
                          return null;
                        },
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                      _buildTextFormField(
                        context: context,
                        hintText: tr('city'),
                        controller: _cityController,
                        keyboardType: TextInputType.name,
                        validator: (content) {
                          return null;
                        },
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                    ],
                  ),
                ),
              ),
              SizedBox(height: defaultPadding),
              DataCard(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('emp_data'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 0.5,
                            ),
                            child: Text(
                              tr('role'),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: ValueListenableBuilder(
                              valueListenable: isEmpAdmin,
                              builder: (context, bool value, _) {
                                print(value);
                                return DropdownButtonFormField<bool>(
                                  value: value,
                                  alignment: AlignmentDirectional.center,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: false,
                                      child: Text(
                                        tr('employee_role'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: true,
                                      child: Text(
                                        tr('admin_role'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ],
                                  onChanged: (isAdmin) {
                                    isEmpAdmin.value = isAdmin!;
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding * 0.5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr('resume'),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                // todo: impelement downloading the resume to user's device
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: primaryColor),
                              child: Text(
                                tr('select'),
                                style: TextStyle(color: secondaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      ValueListenableBuilder(
                        valueListenable: resumeFileName,
                        builder: (contxt, String fileName, _) {
                          return Align(
                            alignment: Alignment.center,
                            child: Text(
                              fileName.isEmpty
                                  ? tr('please_select_a_resume')
                                  : fileName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: fileName.isEmpty
                                          ? Colors.red
                                          : Colors.blue.shade900),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required BuildContext context,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required TextInputType keyboardType,
    bool isPasswordField = false,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      cursorColor: primaryColor,
      keyboardType: keyboardType,
      obscureText: isPasswordField,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).hintColor.withOpacity(0.5)),
        hintText: hintText,
        fillColor: Colors.transparent,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: primaryColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).hintColor.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
