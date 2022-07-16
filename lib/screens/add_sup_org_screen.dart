import 'package:admin/config/constants.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/controllers/mixins/filed_provider.dart';
import 'package:admin/controllers/supportive_organizations/supportive_organizations_bloc.dart';
import 'package:admin/controllers/validation/validation_mixin.dart';
import 'package:admin/models/models.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSupportiveOrganizationScreen extends StatelessWidget
    with ValidationProvider, FieldProvider, DialogProvider {
  AddSupportiveOrganizationScreen({Key? key}) : super(key: key);

  static String routeName() => '/add_sup_org_screen';

  // FORM KEY FOR FORM VALIDATION
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _orgNameArController = TextEditingController();
  final TextEditingController _orgNameEnController = TextEditingController();
  final TextEditingController _orgCityArController = TextEditingController();
  final TextEditingController _orgCityEnController = TextEditingController();
  final TextEditingController _orgStateEnController = TextEditingController();
  final TextEditingController _orgStateArController = TextEditingController();
  final TextEditingController _orgEmailController = TextEditingController();
  final TextEditingController _orgPhoneNumberController =
      TextEditingController();

  // ADD A SUPPORTIVE ORGANIZATION
  void _addSupportiveOrganization(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // SEND (ADD SUPPORTIVE ORGANIZATION) EVENT
      context.read<SupportiveOrganizationsBloc>().add(
            AddSupportiveOrganization(
              SupportiveOrganization(
                nameAr: _orgNameArController.text.trim(),
                nameEn: _orgNameEnController.text.trim(),
                cityAr: _orgCityArController.text.trim(),
                cityEn: _orgCityEnController.text.trim(),
                stateAr: _orgStateArController.text.trim(),
                stateEn: _orgStateEnController.text.trim(),
                email: _orgEmailController.text.trim(),
                phoneNumber: _orgPhoneNumberController.text.trim(),
              ),
            ),
          );
    }
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
            tr('add_sup_org'),
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
                _addSupportiveOrganization(context);
              },
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.black,
              ),
              splashRadius: 20,
            ),
          ],
        ),
        //         int count = 0;
        // Navigator.of(context).popUntil((_) => count++ >= 2);
        body: BlocConsumer<SupportiveOrganizationsBloc,
            SupportiveOrganizationsState>(
          listener: (context, state) {
            if (state is SupportiveOrganizationsLoading) {
              showLoadingDialoge(context);
            } else {
              // IN CASE OF ERROR OCCURRED OR UNKNOWN ERROR STAY IN THE SAME SCREEN
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(defaultPadding),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DataCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            tr('org_info_ar'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('org_name_ar'),
                            controller: _orgNameArController,
                            keyboardType: TextInputType.name,
                            validator: (content) {
                              return content == null || content.isEmpty
                                  ? tr('required')
                                  : null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('city_ar'),
                            controller: _orgCityArController,
                            keyboardType: TextInputType.name,
                            validator: (content) {
                              return content == null || content.isEmpty
                                  ? tr('required')
                                  : null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('state_ar'),
                            controller: _orgStateArController,
                            keyboardType: TextInputType.name,
                            validator: (content) {
                              return content == null || content.isEmpty
                                  ? tr('required')
                                  : null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    DataCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            tr('org_info_en'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('org_name_en'),
                            controller: _orgNameEnController,
                            keyboardType: TextInputType.name,
                            isFieldReversed: true,
                            validator: (content) {
                              return content == null || content.isEmpty
                                  ? tr('required')
                                  : null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('city_en'),
                            controller: _orgCityEnController,
                            keyboardType: TextInputType.name,
                            isFieldReversed: true,
                            validator: (content) {
                              return content == null || content.isEmpty
                                  ? tr('required')
                                  : null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('state_en'),
                            controller: _orgStateEnController,
                            keyboardType: TextInputType.name,
                            isFieldReversed: true,
                            validator: (content) {
                              return content == null || content.isEmpty
                                  ? tr('required')
                                  : null;
                            },
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    DataCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            tr('contact_info'),
                            style: const TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          buildTextFormField(
                            context: context,
                            hintText: tr('email'),
                            controller: _orgEmailController,
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
                          ),
                          const SizedBox(height: defaultPadding * 0.5),
                          buildTextFormField(
                            context: context,
                            hintText: tr('phone_number'),
                            controller: _orgPhoneNumberController,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
