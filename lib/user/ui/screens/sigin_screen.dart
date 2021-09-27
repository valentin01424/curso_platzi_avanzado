import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
 UserBLoc userBLoc;
 
  @override
  Widget build(BuildContext context) {

    userBLoc = BlocProvider.of(context);

    return sigInGoogleUI();
  }

  Widget sigInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("",null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [

              Text("Bienvenido a nuestra Aplicacion",
              style: TextStyle(
                fontSize: 40,
                fontFamily: "Lato",
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              ),
            ButtonGreen(text: "Iniciar con Google", 
            onPressed: (){
            userBLoc.signIn().then((UserCredential user) => print("el usario es ${user.user.displayName}"));

            },
            width: 300,
            height: 60,
            )
            ], 
            
          ),
         
        ],
      ) ,
    );
  }
}