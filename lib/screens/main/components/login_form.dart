
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import '../main_screen.dart';
import '../user_screen.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final paddingTopForm, fontSizeTextField, fontSizeTextFormField, spaceBetweenFields, iconFormSize;
  final spaceBetweenFieldAndButton, widthButton, fontSizeButton, fontSizeForgotPassword, fontSizeSnackBar, errorFormMessage;

  LoginForm(
      this.paddingTopForm, this.fontSizeTextField, this.fontSizeTextFormField, this.spaceBetweenFields, this.iconFormSize, this.spaceBetweenFieldAndButton,
      this.widthButton, this.fontSizeButton, this.fontSizeForgotPassword, this.fontSizeSnackBar, this.errorFormMessage
      );

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * paddingTopForm),
            child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Usuario', style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                         // fontFamily: 'Poppins',
                          color: Colors.white)
                      )
                  ),
                  TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'Introduzca su usuario para continuar!';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2)
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white, fontSize: widthSize * errorFormMessage),
                        prefixIcon: Icon(
                          Icons.person,
                          size: widthSize * iconFormSize,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)
                  ),
                  SizedBox(height: heightSize * spaceBetweenFields),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Contraseña', style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          //fontFamily: 'Poppins',
                          color: Colors.white)
                      )
                  ),
                  TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'Introduzca su contraseña para continuar!';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2)
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2)
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        errorStyle: TextStyle(color: Colors.white, fontSize: widthSize * errorFormMessage),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: widthSize * iconFormSize,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)
                  ),
                  SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        if((_usernameController.text =="admin") &&(_passwordController.text =="admin")){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserScreen()),
                          );
                        }else{
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                backgroundColor: bgColor,
                                title: new Text("Credenciales Incorrectas"),
                                content: new Text("Por favor chequee su nombre de usuario y contraseña"
                                    " e inténtelo nuevamente"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new TextButton(
                                    child: new Text("Cerrar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }

                    },
                    icon: Icon(Icons.login),
                    label: Text("Continuar"),
                  ),
                  SizedBox(height: heightSize * 0.01),
                  Text('Olvidé mi contraseña', style: TextStyle(
                      fontSize: widthSize * fontSizeForgotPassword,
                     // fontFamily: 'Poppins',
                      color: Colors.white)
                  )
                ]
            )
        )
    );
  }

}