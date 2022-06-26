import 'dart:io';

import 'package:admin/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';

class AddDonationCampaignScreen extends StatelessWidget {
  AddDonationCampaignScreen({Key? key}) : super(key: key);

  static routeName() => '/add_donation_campaign';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleArController = TextEditingController();
  final TextEditingController _titleEnController = TextEditingController();
  final TextEditingController _targetDonAmountController =
      TextEditingController();
  final TextEditingController _numOfBenController = TextEditingController();

  // selected image path
  final ValueNotifier<String?> _selectedImagePath =
      ValueNotifier<String?>(null);

  // ENDING DATETIME OF THE CAMPAIGN
  final ValueNotifier<DateTime?> _endingDateTime =
      ValueNotifier<DateTime?>(null);

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
      // ADD ONE DAY TO THE CURRENT TIME TO SET THE LOWER LIMIT AS ONE DAY FROM NOW
      initialDate:
          _endingDateTime.value ?? DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null && picked != _endingDateTime.value) {
      _endingDateTime.value = picked;
      _selectTime(context);
    }
  }

  Future<void> _selectImage(BuildContext context) async {
    final _imagePicker = ImagePicker();
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _selectedImagePath.value = image.path;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
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
      initialTime: _endingDateTime.value == null
          ? TimeOfDay(
              hour: _endingDateTime.value!.hour,
              minute: _endingDateTime.value!.minute)
          : TimeOfDay.now(),
    );
    if (picked != null) {
      _endingDateTime.value = DateTime(
        _endingDateTime.value!.year,
        _endingDateTime.value!.month,
        _endingDateTime.value!.day,
        picked.hour,
        picked.minute,
      );
    }
  }

  Future<bool> _showExitPopup(context, isInAddMode) async {
    return await showDialog(
          // show confirm dialogueO
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('add_donation_campaign'),
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
              // TODO: perform creating a new donation campaign
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
              _DataCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('campaign_info'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    _buildTextFormField(
                      context: context,
                      hintText: tr('don_camp_title_ar'),
                      controller: _titleArController,
                      keyboardType: TextInputType.name,
                      validator: (content) {
                        return null;
                      },
                    ),
                    SizedBox(height: defaultPadding * 0.5),
                    _buildTextFormField(
                      context: context,
                      hintText: tr('don_camp_title_en'),
                      controller: _titleEnController,
                      keyboardType: TextInputType.name,
                      validator: (content) {
                        return null;
                      },
                    ),
                    SizedBox(height: defaultPadding * 0.5),
                    _buildTextFormField(
                      context: context,
                      hintText: tr('target_don_amount'),
                      controller: _targetDonAmountController,
                      keyboardType: TextInputType.number,
                      validator: (content) {
                        return null;
                      },
                    ),
                    SizedBox(height: defaultPadding * 0.5),
                    _buildTextFormField(
                      context: context,
                      hintText: tr('num_of_ben'),
                      controller: _numOfBenController,
                      keyboardType: TextInputType.number,
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
                        valueListenable: _endingDateTime,
                        builder: (context, dateTime, _) {
                          return AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.date_range, size: 20),
                                contentPadding: EdgeInsets.only(
                                  bottom: dateTime == null ? -4 : 4,
                                  left: 4,
                                ),
                                hintText: dateTime == null
                                    ? tr('don_camp_end_date')
                                    : null,
                                labelText: dateTime != null
                                    ? DateFormat(
                                        context.locale == Locale('ar')
                                            ? 'HH:mm - yyyy/MM/dd'
                                            : 'yyyy/MM/dd - HH:mm ',
                                      ).format(dateTime)
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
                  ],
                ),
              ),
              SizedBox(height: defaultPadding),
              _DataCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        tr('camp_cover'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    AspectRatio(
                      aspectRatio: 1,
                      child: ValueListenableBuilder<String?>(
                        valueListenable: _selectedImagePath,
                        builder: (context, path, _) {
                          return path == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 100,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    SizedBox(height: defaultPadding * 0.5),
                                    Text(
                                      tr('pls_select_image'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(context).hintColor,
                                          ),
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(path),
                                    fit: BoxFit.cover,
                                  ),
                                );
                        },
                      ),
                    ),
                    SizedBox(height: defaultPadding * 0.5),
                    TextButton(
                      onPressed: () async {
                        await _selectImage(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        primary: secondaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 2,
                          vertical: defaultPadding * 0.5,
                        ),
                      ),
                      child: Text(tr('select')),
                    ),
                    SizedBox(height: defaultPadding * 0.5),
                  ],
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

class _DataCard extends StatelessWidget {
  const _DataCard({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Material(
        child: InkWell(
          onLongPress: onLongPress,
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
