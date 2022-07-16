import 'dart:io';

import 'package:admin/config/constants.dart';
import 'package:admin/controllers/file/file_bloc.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/controllers/mixins/filed_provider.dart';
import 'package:admin/controllers/persons/persons_bloc.dart';
import 'package:admin/controllers/validation/validation_mixin.dart';
import 'package:admin/models/models.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class AddEditPersonScreen extends StatelessWidget
    with FieldProvider, DialogProvider, ValidationProvider {
  AddEditPersonScreen({Key? key}) : super(key: key);

  static String routeName() => '/add_edit_person';

  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stateEnController = TextEditingController();
  final _stateArController = TextEditingController();
  final _cityEnController = TextEditingController();
  final _cityArController = TextEditingController();
  final _nationalIdNumberController = TextEditingController();
  final _medicalStatusArController = TextEditingController();
  final _medicalStatusEnController = TextEditingController();

  final ValueNotifier<DateTime?> birthDate = ValueNotifier(null);
  final ValueNotifier<String?> healthReportFilePath = ValueNotifier(null);

  // TO HANDLE IF THE HEALTH REPORT PATH HAS BEEN CHANGED
  final ValueNotifier<bool> reportChanged = ValueNotifier(false);

  final DateTime startDate = DateTime.now();

// FUNCTION TO OPEN FILE PICKER TO PICK PDF FILE
  Future<void> _pickFile() async {
    final pickResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickResult != null) {
      healthReportFilePath.value = pickResult.files.first.path;
      reportChanged.value = true;
    }
  }

  // A FUNCTION TO SEND THE PERSON TO THE API
  Future<void> _storePerson(BuildContext context, String reportUrl) async {
    BlocProvider.of<PersonsBloc>(context).add(
      AddPersonWithSpecialNeeds(
        person: Person(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          birthDate: birthDate.value,
          stateEn: _stateEnController.text.trim(),
          stateAr: _stateArController.text.trim(),
          cityEn: _cityEnController.text.trim(),
          cityAr: _cityArController.text.trim(),
          nationalNumber: _nationalIdNumberController.text.trim(),
          healthStatusAr: _medicalStatusArController.text.trim(),
          healthStatusEn: _medicalStatusEnController.text.trim(),
          healthReportUrl: reportUrl,
        ),
      ),
    );
  }

  // A FUNCTION TO SEND THE PERSON TO THE API
  Future<void> _updatePerson(
      BuildContext context, int personId, String reportUrl) async {
    BlocProvider.of<PersonsBloc>(context).add(
      UpdatePersonWithSpecialNeeds(
        person: Person(
          personId: personId,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          birthDate: birthDate.value,
          stateEn: _stateEnController.text.trim(),
          stateAr: _stateArController.text.trim(),
          cityEn: _cityEnController.text.trim(),
          cityAr: _cityArController.text.trim(),
          nationalNumber: _nationalIdNumberController.text.trim(),
          healthStatusAr: _medicalStatusArController.text.trim(),
          healthStatusEn: _medicalStatusEnController.text.trim(),
          healthReportUrl: reportUrl,
        ),
      ),
    );
  }

  // UPLOAD THE HEALTH REPORT TO THE FILE SERVER
  Future<void> _uploadReport(BuildContext context) async {
    BlocProvider.of<FileBloc>(context).add(
      UploadFile(
        file: File(healthReportFilePath.value!),
        fileName: basename(healthReportFilePath.value!),
      ),
    );
  }

  _fillPersonData(Person person) {
    _firstNameController.text = person.firstName!;
    _lastNameController.text = person.lastName!;
    _phoneController.text = person.phoneNumber!;
    _stateEnController.text = person.stateEn!;
    _stateArController.text = person.stateAr!;
    _cityArController.text = person.cityAr!;
    _cityEnController.text = person.cityEn!;

    // todo: add birthDateVariable here
    birthDate.value = person.birthDate;

    _nationalIdNumberController.text = person.nationalNumber!;
    _medicalStatusArController.text = person.healthStatusAr!;
    _medicalStatusEnController.text = person.healthStatusEn!;

    // health report document file url
    healthReportFilePath.value = person.healthReportUrl!;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primaryColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: primaryColor.withOpacity(0.5), // body text color
              ),
            ),
            child: child!,
          );
        },
        initialDate: birthDate.value ?? DateTime(2000),
        firstDate: DateTime(1940),
        // subtract 3 years from current year to prevent user from selecting near date
        lastDate: DateTime.now().subtract(const Duration(days: 365 * 3)));
    if (picked != null && picked != birthDate.value) {
      birthDate.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final Person? person = data['person'];
    if (person != null) _fillPersonData(person);
    final isInAddMode = data['isInAddMode'];
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            isInAddMode ? tr('add_person') : tr('edit_person'),
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
                // if (isInAddMode) {
                //   // START UPLOADING FILES THEN SEND EMPLOYEE TO SERVER
                //   if (_formKey.currentState!.validate() &&
                //       resumeFileName.value != null) {
                //     _uploadFile(context);
                //   }
                // } else {
                //   // UPDATE EMPLOYEE IN SERVER
                //   if (_formKey.currentState!.validate() &&
                //       resumeFileName.value != null) {
                //     if (resumeChanged.value) {
                //       _uploadFile(context);
                //     } else {
                //       _updateEmployee(context, emp!.cvFileUrl!, emp);
                //       int count = 0;
                //       Navigator.of(context).popUntil((_) => count++ >= 2);
                //     }
                //   }
                // }
                if (isInAddMode) {
                  if (_formKey.currentState!.validate() &&
                      healthReportFilePath.value != null) {
                    _uploadReport(context);
                  }
                } else {
                  if (_formKey.currentState!.validate() &&
                      healthReportFilePath.value != null) {
                    if (reportChanged.value) {
                      _uploadReport(context);
                    } else {
                      _updatePerson(
                        context,
                        person!.personId!,
                        person.healthReportUrl!,
                      );
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }
                  }
                }
                // // VALIDATE THE FORM
                // if (_formKey.currentState!.validate() &&
                //     healthReportFilePath.value != null) {
                //   if (reportChanged.value) {
                //     // UPLOAD REPORT TO THE FILE SERVER
                //     _uploadReport(context);
                //   } else {
                //     // SEND THE PERSON TO THE API
                //     if (!isInAddMode) {
                //       _updatePerson(
                //         context,
                //         person!.personId!,
                //         healthReportFilePath.value!,
                //       );
                //     }
                //   }
                // }
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
              showLoadingDialoge(
                  context, 'assets/animations/uploading_animation.json');
            }

            if (state is FileUploaded) {
              // ! TO CLOSE THE LOADING DIALOG
              healthReportFilePath.value = state.url;
              Navigator.pop(context);

              // SEND THE PERSON TO THE API
              if (isInAddMode) {
                // ! SEND PERSON TO SERVER
                _storePerson(context, state.url);
              } else {
                // ! UPDATE PERSON ON THE SERVER
                _updatePerson(
                  context,
                  person!.personId!,
                  state.url,
                );
              }

              // ! GO TO PERSONS SCREEN
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
                          GestureDetector(
                            onTap: () {
                              // show date picker dialogue
                              _selectDate(context);
                            },
                            child: ValueListenableBuilder<DateTime?>(
                              valueListenable: birthDate,
                              builder: (context, dateTime, _) {
                                return AbsorbPointer(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.date_range,
                                          size: 20),
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 4, left: 4),
                                      hintText: dateTime == null
                                          ? tr('birth_date')
                                          : null,
                                      labelText: dateTime != null
                                          ? DateFormat('yyyy/MM/dd')
                                              .format(dateTime)
                                          : null,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(height: 0.5),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.5),
                                          ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: primaryColor,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('nat_id_num'),
                            controller: _nationalIdNumberController,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              if (!validateNationalID(content)) {
                                return tr('invalid_nat_id_num');
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
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
                            tr('health_information'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('medical_status_ar'),
                            controller: _medicalStatusArController,
                            keyboardType: TextInputType.text,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('required');
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('medical_status_en'),
                            controller: _medicalStatusEnController,
                            isFieldReversed: true,
                            keyboardType: TextInputType.text,
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
                            tr('medical_docs'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 0.5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tr('health_report'),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // OPEN FILE PICKER TO SELECT HEALTH REPORT AS PDF FILE
                                    _pickFile();
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: primaryColor),
                                  child: Text(
                                    tr('select'),
                                    style:
                                        const TextStyle(color: secondaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          ValueListenableBuilder<String?>(
                            valueListenable: healthReportFilePath,
                            builder: (context, String? filePath, _) {
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  filePath == null
                                      ? tr('please_select_a_health_report')
                                      : basename(filePath),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: filePath == null
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
