import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';
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
  AsyncSnapshot snapshot;
  double screenWidth; 
  @override
  Widget build(BuildContext context) {

    userBLoc = BlocProvider.of(context);

    return _stateSession();
  }

  Widget _stateSession(){
    return StreamBuilder(
      stream: userBLoc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
       if (!snapshot.hasData || snapshot.hasError) {
         return sigInGoogleUI();
         
       }else{
         return PlatziTripsCupertino();
       }           
      },
      );
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
            userBLoc.signIn();

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