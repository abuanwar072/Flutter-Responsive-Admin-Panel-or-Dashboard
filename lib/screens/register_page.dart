import 'package:yupcity_admin/bloc/auth/register_bloc/register_fields_form_bloc.dart';
import 'package:yupcity_admin/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

class RegisterScreenPage extends StatefulWidget {
  const RegisterScreenPage({Key? key}) : super(key: key);

  @override
  _RegisterScreenPageState createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreenPage> {
  late TextStyle? _headLineStyle;

  late TextStyle? _textLineStyle;

  late bool _passwordVisible;

  late bool _confirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _confirmPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    _headLineStyle = Theme.of(context).textTheme.headline5;
    _textLineStyle = Theme.of(context).textTheme.bodyText1;
    late RegisterFieldsFormBloc formBloc;
    return BlocProvider(
      create: (context) => RegisterFieldsFormBloc(),
      child: Builder(builder: (BuildContext context) {
        formBloc = BlocProvider.of<RegisterFieldsFormBloc>(context);
        return Scaffold(
            backgroundColor: const Color(0xFFF1F5F8),
            body: FormBlocListener<RegisterFieldsFormBloc, String, String>(
              onSubmitting: (context, state) {
                //LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                GetIt.I.get<NavigationService>().navigateToWithParams(
                    NavigationService.activatePage,
                    state.successResponse);
              },
              onFailure: (context, state) {
                debugPrint(state.failureResponse);
                // LoadingDialog.hide(context);
                Fluttertoast.showToast(
                    msg: state.failureResponse!,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                );
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 40.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: 300,
                          height: 100,
                          child: Image.asset(
                            "assets/svg/yupcharge_logo.png",
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                       /* Text(I18n.of(context).login_title,
                            style: GoogleFonts.manrope(textStyle: _headLineStyle?.apply(color: Color(0xFF48B3C9),),fontSize: 32, fontWeight: FontWeight.w700)),
                        Text(
                          I18n.of(context).login_message,
                          style: GoogleFonts.manrope(fontWeight: FontWeight.w700, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 40,
                        ),*/
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.textName,
                            decoration: InputDecoration(
                              labelText: "Name",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            )),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.textEmail,
                          decoration: InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                       /* TextFieldBlocBuilder(
                            textFieldBloc: formBloc.textTelephone,
                            decoration: InputDecoration(
                              labelText: I18n.of(context).textfield_telephone,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            )), */
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.textPassword,
                          obscureText: _passwordVisible,
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible
                                      ? _passwordVisible = false
                                      : _passwordVisible = true;
                                });
                              },
                            ),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.textPassword2,
                          obscureText: _confirmPasswordVisible,
                          decoration: InputDecoration(
                            labelText:
                                "Confirmar contraseña",
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _confirmPasswordVisible
                                      ? _confirmPasswordVisible = false
                                      : _confirmPasswordVisible = true;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          onPressed: () {
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
                          child: Text("Registrar"),
                        ),
                        RawMaterialButton(
                            onPressed: () {
                              GetIt.I.get<NavigationService>().navigateTo(NavigationService.loginPage);
                            },
                            child: Text("Iniciar")),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
