import 'package:admin/config/constants.dart';
import 'package:admin/controllers/mixins/filed_provider.dart';
import 'package:admin/widgets/data_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget with FieldProvider {
  LoginScreen({Key? key}) : super(key: key);

  static String routeName() => '/login_screen';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tr('login'),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: primaryColor),
                        ),
                        const SizedBox(height: defaultPadding * 2),
                        Flexible(
                          child: Lottie.asset(
                            'assets/animations/login_animation.json',
                            width: MediaQuery.of(context).size.width * 0.6,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                          ),
                          child: Text(
                            tr('login_title'),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: defaultPadding * 3),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding * 1.5),
                    child: DataCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildTextFormField(
                              context: context,
                              hintText: tr('email'),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              isFieldReversed: true,
                              validator: (content) {
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding * 1.5),
                            buildTextFormField(
                              context: context,
                              hintText: tr('password'),
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              isPasswordField: true,
                              validator: (content) {
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding * 3),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              child: Text(
                                tr('login'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
