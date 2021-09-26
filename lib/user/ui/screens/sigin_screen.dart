import 'package:flutter/material.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';

class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
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