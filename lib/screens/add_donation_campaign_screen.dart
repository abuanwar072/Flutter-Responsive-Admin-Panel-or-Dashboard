import 'dart:io';

import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/controllers/donation_campaigns/donation_campaigns_bloc.dart';
import 'package:admin/controllers/file/file_bloc.dart';
import 'package:admin/controllers/mixins/mixins.dart';
import 'package:admin/controllers/validation/validation_mixin.dart';
import 'package:admin/models/donation_campaign.dart';
import 'package:admin/models/type_of_campaign.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddDonationCampaignScreen extends StatelessWidget
    with DialogProvider, FieldProvider, ValidationProvider {
  AddDonationCampaignScreen({Key? key}) : super(key: key);

  static routeName() => '/add_donation_campaign';
  final _formKey = GlobalKey<FormState>();

  final _titleArController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _targetDonAmountController = TextEditingController();
  final _numOfBenController = TextEditingController();

  // SELECTED IMAGE PATH
  final ValueNotifier<String?> _selectedImagePath =
      ValueNotifier<String?>(null);

  // TYPE OF CAMPAIGN
  final ValueNotifier<TypeOfCampaign?> _typeOfCampaign =
      ValueNotifier<TypeOfCampaign?>(null);

  // ENDING DATETIME OF THE CAMPAIGN
  // final ValueNotifier<DateTime?> _endingDateTime =
  //     ValueNotifier<DateTime?>(null);

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: primaryColor, // header background color
  //             onPrimary: Colors.white, // header text color
  //             onSurface: primaryColor.withOpacity(0.5), // body text color
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //     // ADD ONE DAY TO THE CURRENT TIME TO SET THE LOWER LIMIT AS ONE DAY FROM NOW
  //     initialDate:
  //         _endingDateTime.value ?? DateTime.now().add(Duration(days: 1)),
  //     firstDate: DateTime.now().add(Duration(days: 1)),
  //     lastDate: DateTime.now().add(Duration(days: 30)),
  //   );
  //   if (picked != null && picked != _endingDateTime.value) {
  //     _endingDateTime.value = picked;
  //     _selectTime(context);
  //   }
  // }

  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: primaryColor, // header background color
  //             onPrimary: Colors.white, // header text color
  //             onSurface: primaryColor.withOpacity(0.5), // body text color
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //     initialTime: _endingDateTime.value == null
  //         ? TimeOfDay(
  //             hour: _endingDateTime.value!.hour,
  //             minute: _endingDateTime.value!.minute)
  //         : TimeOfDay.now(),
  //   );
  //   if (picked != null) {
  //     _endingDateTime.value = DateTime(
  //       _endingDateTime.value!.year,
  //       _endingDateTime.value!.month,
  //       _endingDateTime.value!.day,
  //       picked.hour,
  //       picked.minute,
  //     );
  //   }
  // }

  // A HELPER FUNCTION TO SELECT A COVER FOR THE CAMPAIGN FROM GALLARY
  Future<void> _selectImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _selectedImagePath.value = image.path;
    }
  }

  // SAVE THE DONATION CAMPAIGN TO THE SERVER
  Future<void> _saveDonationCampaign(BuildContext context, String url) async {
    context.read<DonationCampaignsBloc>().add(StoreDonationCampaign(
          DonationCampaign(
            titleAr: _titleArController.text.trim(),
            titleEn: _titleEnController.text.trim(),
            targetAmount: double.parse(_targetDonAmountController.text),
            numberOfBeneficiaries: int.parse(_numOfBenController.text),
            typeOfCampaignId: _typeOfCampaign.value!.typeId,
            coverImageUrl: url,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Scaffold(
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
                // ! CHECK IF THE FORM IS VALID
                if (_formKey.currentState!.validate() &&
                    _selectedImagePath.value != null) {
                  // ! IF THE FORM IS VALID, START UPLOADING THE IMAGE
                  BlocProvider.of<FileBloc>(context).add(
                    UploadImage(file: File(_selectedImagePath.value!)),
                  );
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
          listener: (context, state) async {
            if (state is FileUploading) {
              Helper.logger.d('MUST SHOW LOADING');
              await showLoadingDialoge(context,'assets/animations/uploading_animation.json');
            } else if (state is FileUploaded) {
              _saveDonationCampaign(context, state.url);
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
              // Navigator.pop(context);
            } else {
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
                  _DataCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('campaign_info'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        buildTextFormField(
                          context: context,
                          hintText: tr('don_camp_title_ar'),
                          controller: _titleArController,
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
                          hintText: tr('don_camp_title_en'),
                          controller: _titleEnController,
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
                        ValueListenableBuilder<TypeOfCampaign?>(
                          valueListenable: _typeOfCampaign,
                          builder: (context, type, _) {
                            return DropdownButtonFormField<TypeOfCampaign?>(
                              value: type,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              validator: (content) {
                                if (content == null) {
                                  return tr('required');
                                }
                                return null;
                              },
                              items: [
                                DropdownMenuItem<TypeOfCampaign?>(
                                  value: null,
                                  child: Text(
                                    tr('type_of_campaign'),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                for (TypeOfCampaign typeOfCampaign
                                    in Helper.typesOfCampaigns)
                                  DropdownMenuItem<TypeOfCampaign?>(
                                    value: typeOfCampaign,
                                    child: Text(
                                      Helper.isLocaleArabic(context)
                                          ? typeOfCampaign.typeNameAr
                                          : typeOfCampaign.typeNameEn,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                              onChanged: (type) {
                                _typeOfCampaign.value = type;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                        buildTextFormField(
                          context: context,
                          hintText: tr('target_don_amount'),
                          controller: _targetDonAmountController,
                          keyboardType: TextInputType.number,
                          suffixText: '\$',
                          validator: (content) {
                            if (content == null || content.isEmpty) {
                              return tr('required');
                            }

                            if (!validatePrice(content)) {
                              return tr('invalid_price');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                        buildTextFormField(
                          context: context,
                          hintText: tr('num_of_ben'),
                          controller: _numOfBenController,
                          keyboardType: TextInputType.number,
                          validator: (content) {
                            if (content == null || content.isEmpty) {
                              return tr('required');
                            }

                            // VALIDATE THE ENTEREND NUM IS INT AND GREATER THAT 0
                            if (int.tryParse(content) == null ||
                                int.tryParse(content)! <= 0) {
                              return tr('invalid_num');
                            }

                            return null;
                          },
                        ),
                        // SizedBox(height: defaultPadding * 0.5),
                        // GestureDetector(
                        //   onTap: () {
                        //     // show date picker dialogue
                        //     _selectDate(context);
                        //   },
                        //   child: ValueListenableBuilder<DateTime?>(
                        //     valueListenable: _endingDateTime,
                        //     builder: (context, dateTime, _) {
                        //       return AbsorbPointer(
                        //         child: TextFormField(
                        //           decoration: InputDecoration(
                        //             icon: Icon(Icons.date_range, size: 20),
                        //             contentPadding: EdgeInsets.only(
                        //               bottom: dateTime == null ? -4 : 4,
                        //               left: 4,
                        //             ),
                        //             hintText: dateTime == null
                        //                 ? tr('don_camp_end_date')
                        //                 : null,
                        //             labelText: dateTime != null
                        //                 ? DateFormat(
                        //                     Helper.isLocaleArabic(context)
                        //                         ? 'HH:mm - yyyy/MM/dd'
                        //                         : 'yyyy/MM/dd - HH:mm ',
                        //                     context.locale.languageCode,
                        //                   ).format(dateTime)
                        //                 : null,
                        //             labelStyle: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyMedium!
                        //                 .copyWith(height: 0.5),
                        //             hintStyle: Theme.of(context)
                        //                 .textTheme
                        //                 .bodySmall!
                        //                 .copyWith(
                        //                   color: Theme.of(context)
                        //                       .hintColor
                        //                       .withOpacity(0.5),
                        //                 ),
                        //             filled: true,
                        //             fillColor: Colors.transparent,
                        //             focusedBorder: UnderlineInputBorder(
                        //               borderSide: BorderSide(
                        //                 width: 1,
                        //                 color: primaryColor,
                        //               ),
                        //             ),
                        //             enabledBorder: UnderlineInputBorder(
                        //               borderSide: BorderSide(
                        //                 width: 1,
                        //                 color: Theme.of(context)
                        //                     .hintColor
                        //                     .withOpacity(0.2),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: defaultPadding * 0.5),
                      ],
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  _DataCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            tr('camp_cover'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        AspectRatio(
                          aspectRatio: 1,
                          child: ValueListenableBuilder<String?>(
                            valueListenable: _selectedImagePath,
                            builder: (context, path, _) {
                              return path == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 100,
                                          color: Theme.of(context).hintColor,
                                        ),
                                        const SizedBox(
                                            height: defaultPadding * 0.5),
                                        Text(
                                          tr('pls_select_image'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                        ),
                                      ],
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        File(path),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                            },
                          ),
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                        TextButton(
                          onPressed: () async {
                            await _selectImage(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            primary: secondaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 2,
                              vertical: defaultPadding * 0.5,
                            ),
                          ),
                          child: Text(tr('select')),
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                      ],
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

class _DataCard extends StatelessWidget {
  const _DataCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Material(
        child: InkWell(
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
