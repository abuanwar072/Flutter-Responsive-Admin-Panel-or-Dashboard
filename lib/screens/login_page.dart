import 'package:yupcity_admin/bloc/auth/login_bloc/login_fields_form_bloc.dart';
import 'package:yupcity_admin/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yupcity_admin/services/navigator_service.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  late TextStyle? _headLineStyle;

  late TextStyle? _textLineStyle;

  late bool? _passwordVisible;

 // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    _headLineStyle = Theme.of(context).textTheme.headline5;
    _textLineStyle = Theme.of(context).textTheme.bodyText1;
    _textLineStyle?.apply(fontWeightDelta: 12);
    return BlocProvider(
      create: (context) => LoginFieldsFormBloc(),
      child: Builder(builder: (BuildContext context) {
        final formBloc = BlocProvider.of<LoginFieldsFormBloc>(context);
        if (kDebugMode) {
          formBloc.textEmail.updateInitialValue("jordi.buges@gmail.com");
          formBloc.textPassword.updateInitialValue("123456");
          /*formBloc.textEmail.updateInitialValue("jgrimal90@gmail.com");
          formBloc.textPassword.updateInitialValue("12345678");*/
          //formBloc.textEmail.updateInitialValue("holahola@gmail.com");
          //formBloc.textPassword.updateInitialValue("12345678");
        }

        return
           Scaffold(
              // backgroundColor: Colors.black,
              backgroundColor: const Color(0xFFF1F5F8),
              body: FormBlocListener<LoginFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  var email = formBloc.textEmail.value;
                  var password = formBloc.textPassword.value;
                  // BlocProvider.of<LoginBlocBloc>(context).add(DoLoginEvent(email, password));
                },
                onSuccess: (context, state) {
                  if (state is FormBlocSuccess<String, String>) {
                    GetIt.I.get<NavigationService>().navigateToWithParams(
                        NavigationService.dashBoardPage,
                        state.successResponse);
                  }

                  //LoadingDialog.hide(context);
                },
                onFailure: (context, state) {
                  Fluttertoast.showToast(
                      msg: state.failureResponse!,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1
                  );
                },
                child: Stack(
                  children: [
                    /*Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: VideoPlayer(_controller)),*/
                    SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          child: Column(
                            children: [

                              Container(
                                width: 300,
                                height: 100,
                                child: Image.asset(
                                  "assets/svg/yupcharge_logo.png",
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 300,
                                height: 200,
                                child: Image.asset(
                                  "assets/svg/trap.png",
                                ),
                              ),
                              /*Text(I18n.of(context).login_title,
                                  style: GoogleFonts.manrope(textStyle: _headLineStyle?.apply(color: Color(0xFF48B3C9),),fontSize: 32, fontWeight: FontWeight.w700)),
                              Text(
                                I18n.of(context).login_message,
                                style: GoogleFonts.manrope(fontWeight: FontWeight.w700, fontSize: 28),
                                textAlign: TextAlign.center,
                              ),*/
                              const SizedBox(
                                height: 40,
                              ),
                              TextFieldBlocBuilder(
                                textFieldBloc: formBloc.textEmail,
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  hoverColor: Colors.white,
                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(16),
                                  labelText: "Email",
                                  fillColor: Colors.white,
                                ),
                              ),
                              TextFieldBlocBuilder(

                                textFieldBloc: formBloc.textPassword,
                                suffixButton: SuffixButton.obscureText,
                                autofillHints: const [AutofillHints.password],

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  labelText: "Password",
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible ?? false
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible ?? false
                                            ? _passwordVisible = false
                                            : _passwordVisible = true;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              /*RawMaterialButton(
                                  onPressed: onPressedRecover,
                                  child: Text("Iniciar")), */
                              ElevatedButton(
                                onPressed: () {
                                  //GetIt.I.get<NavigationService>().navigateTo("datsmi_dashboarPage");
                                  formBloc.submit();
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 60)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(Colors.blue),
                                    shape: MaterialStateProperty.all(
                                        const StadiumBorder())),
                                child: Text("Iniciar"),
                              ),
                             /* RawMaterialButton(
                                  onPressed: onPressedRegister,
                                  child: Text(
                                    I18n.of(context).login_register,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  )),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedRecover() {
    GetIt.I.get<NavigationService>().navigateTo(NavigationService.recoverPage);
  }

  void onPressedRegister() {
    GetIt.I.get<NavigationService>().navigateTo(NavigationService.registerPage);
  }
}
