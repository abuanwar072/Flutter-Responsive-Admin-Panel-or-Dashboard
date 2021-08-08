import 'package:admin/screens/main/user_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/login_form.dart';

class MobileMode extends StatefulWidget {
  @override
  _MobileModeState createState() => _MobileModeState();
}

class _MobileModeState extends State<MobileMode> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
            child: Container(
                color: bgColor,
                child: Column(
                    children: [
                      Image.asset('assets/images/ic_logo.png', height: heightSize * 0.3, width: widthSize * 0.6),
                      SingleChildScrollView(
                        child: _formLogin(context),
                          // child: LoginForm(
                          //     0.007,
                          //     0.04,
                          //     widthSize * 0.04,
                          //     0.06,
                          //     0.04,
                          //     0.07,
                          //     widthSize * 0.09,
                          //     0.05,
                          //     0.032,
                          //     0.04,
                          //     0.032
                          // )
                      )
                    ]
                )
            )
        )
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: 'Introduzca su nombre de usuario',
            filled: true,
            fillColor: secondaryColor,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            counterText: 'Olvidaste la contraseña?',
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: secondaryColor,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            /*boxShadow: [
              BoxShadow(
                color: Colors.deepPurple,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],*/
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Iniciar sesión"))),
            onPressed: (){

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
            },
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("O contacta a los administradores"),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              height: 50,
            ),
          ),
        ]),
        SizedBox(height: 40),

        ElevatedButton(
          child: Container(
              width: double.infinity,
              height: 50,
              child: Center(child: Text("Contactar a los administradores"))),
          onPressed: () => print("it's pressed"),
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _loginWithButton(image: 'images/google.png'),
            _loginWithButton(image: 'images/github.png', isActive: true),
            _loginWithButton(image: 'images/facebook.png'),
          ],
        ),*/
      ],
    );
  }
}