import 'dart:io';

import 'package:admin/config/constants.dart';
import 'package:admin/controllers/employees/employees_bloc.dart';
import 'package:admin/controllers/file/file_bloc.dart';
import 'package:admin/controllers/mixins/mixins.dart';
import 'package:admin/controllers/validation/validation_mixin.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class AddEditEmployeeScreen extends StatelessWidget
    with ValidationProvider, DialogProvider, FieldProvider {
  static String routeName() => '/add_edit_employee';

  AddEditEmployeeScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _stateEnController = TextEditingController();
  final _stateArController = TextEditingController();
  final _cityEnController = TextEditingController();
  final _cityArController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<bool> isEmpAdmin = ValueNotifier(false);
  final ValueNotifier<String?> resumeFileName = ValueNotifier(null);

  // STORES THE FILE STORED URL
  final ValueNotifier<String?> resumeFileUrl = ValueNotifier(null);

  // TO HANDLE IF THE RESUME HAS BEEN CHANGED
  final ValueNotifier<bool> resumeChanged = ValueNotifier(false);

  _fillEmployeeData(Employee emp) {
    _firstNameController.text = emp.firstName!;
    _lastNameController.text = emp.lastName!;
    _phoneController.text = emp.phoneNumber!;
    _emailController.text = emp.email!;
    _stateEnController.text = emp.stateEn!;
    _stateArController.text = emp.stateAr!;
    _cityEnController.text = emp.cityEn!;
    _cityArController.text = emp.cityAr!;

    isEmpAdmin.value = emp.isAdmin!;
    resumeFileName.value = emp.cvFileUrl;
  }

  _uploadFile(context) {
    if (resumeChanged.value && resumeFileName.value != null) {
      BlocProvider.of<FileBloc>(context).add(
        UploadFile(
          file: File(resumeFileName.value!),
          fileName: basename(resumeFileName.value!),
        ),
      );
    }
  }

  // SEND EMPLOYEE TO SERVER
  Future<void> _storeEmployee(BuildContext context, String docUrl) async {
    BlocProvider.of<EmployeesBloc>(context).add(
      StoreEmployee(
        employee: Employee(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phoneNumber: _phoneController.text,
          email: _emailController.text.trim(),
          password: _passwordController.text,
          cityEn: _cityEnController.text.trim(),
          cityAr: _cityArController.text.trim(),
          stateAr: _stateArController.text.trim(),
          stateEn: _stateEnController.text.trim(),
          cvFileUrl: docUrl,
          isAdmin: isEmpAdmin.value,
        ),
      ),
    );
  }

  // UPDATE EMPLOYEE IN SERVER
  Future<void> _updateEmployee(
      BuildContext context, String docUrl, Employee emp) async {
    BlocProvider.of<EmployeesBloc>(context).add(
      UpdateEmployee(
        employee: Employee(
          empId: emp.empId,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phoneNumber: _phoneController.text,
          email: _emailController.text.trim(),
          password: _passwordController.text,
          cityEn: _cityEnController.text.trim(),
          cityAr: _cityArController.text.trim(),
          stateEn: _stateEnController.text.trim(),
          stateAr: _stateArController.text.trim(),
          cvFileUrl: docUrl,
          isAdmin: isEmpAdmin.value,
        ),
      ),
    );
  }

  // A HELPER FUNCTION TO OPEN FILE PICKER TO PICK A PDF FILE AND STORE IT'S PATH IN THE RESUME FILE NAME VALUE NOTIFIER
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      resumeFileName.value = result.files.single.path;
      resumeChanged.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final Employee? emp = data['employee'];
    if (emp != null) _fillEmployeeData(emp);
    final isInAddMode = data['isInAddMode'];
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Scaffold(
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
            onPressed: () async {
              if (await showExitPopup(context)) Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            splashRadius: 20,
          ),
          actions: [
            IconButton(
              onPressed: () {
                // todo: perform update functionality

                if (isInAddMode) {
                  // START UPLOADING FILES THEN SEND EMPLOYEE TO SERVER
                  if (_formKey.currentState!.validate() &&
                      resumeFileName.value != null) {
                    _uploadFile(context);
                  }
                } else {
                  // UPDATE EMPLOYEE IN SERVER
                  if (_formKey.currentState!.validate() &&
                      resumeFileName.value != null) {
                    if (resumeChanged.value) {
                      _uploadFile(context);
                    } else {
                      _updateEmployee(context, emp!.cvFileUrl!, emp);
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }
                  }
                }
              },
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.black,
              ),
              splashRadius: 20,
            ),
          ],
        ),
        body: BlocListener<FileBloc, FileState>(
          listener: (context, state) {
            if (state is FileUploading) {
              showLoadingDialoge(context,'assets/animations/uploading_animation.json');
            }
            if (state is FileUploaded) {
              // ! TO CLOSE THE LOADING DIALOG
              Navigator.pop(context);
              if (isInAddMode) {
                // ! SEND EMPLOYEE TO SERVER
                _storeEmployee(context, state.url);
              } else {
                // ! SEND EMPLOYEE TO SERVER
                _updateEmployee(
                  context,
                  state.url,
                  emp!,
                );
              }

              // ! GO TO EMPLOYEES SCREEN
              if (!isInAddMode) {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              } else {
                Navigator.pop(context);
              }
            }

            if (state is FileFaliure) {
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('first_name'),
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('last_name'),
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('phone_number'),
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            isFieldReversed: true,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }

                              if (!validatePhoneNumber(content)) {
                                return tr('invalid_phone_number');
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          BlocBuilder<EmployeesBloc, EmployeesState>(
                            builder: (context, state) {
                              if (state is EmployeesFailure) {
                                if (state.message == 'EMAIL IS ALREADY USED') {
                                  return buildTextFormField(
                                    context: context,
                                    hintText: tr('email'),
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    errorMessage: tr('email_is_used'),
                                    isFieldReversed: true,
                                    validator: (content) {
                                      if (content == null || content.isEmpty) {
                                        return tr('required');
                                      }
                                      if (!validateEmailAddress(content)) {
                                        return tr('invalid_email');
                                      }
                                      return null;
                                    },
                                  );
                                }
                              }
                              return buildTextFormField(
                                context: context,
                                hintText: tr('email'),
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                isFieldReversed: true,
                                validator: (content) {
                                  if (content == null || content.isEmpty) {
                                    return tr('required');
                                  }
                                  if (!validateEmailAddress(content)) {
                                    return tr('invalid_email');
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          if (emp == null)
                            Column(
                              children: [
                                const SizedBox(height: defaultPadding * 0.5),
                                buildTextFormField(
                                  context: context,
                                  hintText: tr('password'),
                                  isPasswordField: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _passwordController,
                                  validator: (content) {
                                    if (content == null || content.isEmpty) {
                                      return tr('required');
                                    }
                                    if (content.length < 8) {
                                      return tr('password_too_short');
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(height: defaultPadding * 0.5)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  DataCard(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('address_ar'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('state_ar'),
                            controller: _stateArController,
                            keyboardType: TextInputType.name,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('city_ar'),
                            controller: _cityArController,
                            keyboardType: TextInputType.name,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  DataCard(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('address_en'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('state_en'),
                            controller: _stateEnController,
                            keyboardType: TextInputType.name,
                            isFieldReversed: true,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('city_en'),
                            controller: _cityEnController,
                            keyboardType: TextInputType.name,
                            isFieldReversed: true,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  DataCard(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('emp_data'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
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
                                width: 120,
                                child: ValueListenableBuilder(
                                  valueListenable: isEmpAdmin,
                                  builder: (context, bool value, _) {
                                    if (kDebugMode) print(value);
                                    return DropdownButtonFormField<bool>(
                                      value: value,
                                      alignment: AlignmentDirectional.center,
                                      decoration: const InputDecoration(
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
                          const SizedBox(height: defaultPadding * 0.5),
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
                                ValueListenableBuilder<String?>(
                                  valueListenable: resumeFileName,
                                  builder: (context, path, _) {
                                    return TextButton(
                                      onPressed: () {
                                        _pickFile();
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: primaryColor),
                                      child: Text(
                                        tr('select'),
                                        style: const TextStyle(
                                            color: secondaryColor),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          ValueListenableBuilder<String?>(
                            valueListenable: resumeFileName,
                            builder: (ctx, String? fileName, _) {
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  fileName == null
                                      ? tr('please_select_a_resume')
                                      : basename(fileName),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: fileName == null
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
        ),
      ),
    );
  }
}
