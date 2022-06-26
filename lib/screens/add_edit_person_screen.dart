import 'package:admin/constants.dart';
import 'package:admin/models/models.dart';
import 'package:admin/reusable_widgets/reusable_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AddEditPersonScreen extends StatelessWidget {
  AddEditPersonScreen({Key? key}) : super(key: key);

  static String routeName() => '/add_edit_person';

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _stateController = TextEditingController();
  final _nationalIdNumberController = TextEditingController();
  final _medicalStatusArController = TextEditingController();
  final _medicalStatusEnController = TextEditingController();

  final ValueNotifier<DateTime?> birthDate = ValueNotifier(null);
  final ValueNotifier<String> healthReportFileName = ValueNotifier('');

  final DateTime startDate = DateTime.now();

  _fillEmployeeData(Person person) {
    _firstNameController.text = person.firstName!;
    _lastNameController.text = person.lastName!;
    _phoneController.text = person.phoneNumber!;
    _stateController.text = person.state!;

    // todo: add birthDateVariable here
    birthDate.value = person.birthDate;

    _nationalIdNumberController.text = person.nationalNumber!;
    _medicalStatusArController.text = person.healthStatusAr!;
    _medicalStatusEnController.text = person.healthStatusEn!;

    // health report document file url
    healthReportFileName.value = person.healthReportUrl!;
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
        lastDate: DateTime.now().subtract(Duration(days: 365 * 3)));
    if (picked != null && picked != birthDate.value) {
      birthDate.value = picked;
    }
  }

  Future<bool> _showExitPopup(context, isInAddMode) async {
    return await showDialog(
          // show confirm dialogue
          // the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('discard_changes').tr(),
            content: Text(
              isInAddMode
                  ? 'discard_person_insertion'
                  : 'discard_person_update',
              style: Theme.of(context).textTheme.bodyMedium,
            ).tr(),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('no', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.red.withOpacity(0.1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('yes', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; // if showDialogue had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final Person? person = data['person'];
    if (person != null) _fillEmployeeData(person);
    final isInAddMode = data['isInAddMode'];
    return WillPopScope(
      onWillPop: () {
        return _showExitPopup(context, isInAddMode);
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
                // todo: perform update person functionality
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
                                    icon: Icon(Icons.date_range, size: 20),
                                    contentPadding:
                                        EdgeInsets.only(bottom: 4, left: 4),
                                    hintText: dateTime == null
                                        ? tr('birth_date')
                                        : null,
                                    labelText: dateTime != null
                                        ? Jiffy(dateTime, "dd, MM yyyy").yMd
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
                                    focusedBorder: UnderlineInputBorder(
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
                        SizedBox(height: defaultPadding * 0.5),
                        _buildTextFormField(
                          context: context,
                          hintText: tr('nat_id_num'),
                          controller: _nationalIdNumberController,
                          validator: (content) {
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
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
                          tr('health_information'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        _buildTextFormField(
                          context: context,
                          hintText: tr('medical_status_ar'),
                          controller: _medicalStatusArController,
                          keyboardType: TextInputType.text,
                          validator: (content) {
                            return null;
                          },
                        ),
                        SizedBox(height: defaultPadding),
                        _buildTextFormField(
                          context: context,
                          hintText: tr('medical_status_en'),
                          controller: _medicalStatusEnController,
                          keyboardType: TextInputType.text,
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
                          tr('medical_docs'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
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
                                  // todo: implement downloading the health report to user's device
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
                          valueListenable: healthReportFileName,
                          builder: (context, String fileName, _) {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                fileName.isEmpty
                                    ? tr('please_select_a_health_report')
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
