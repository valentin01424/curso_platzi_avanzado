import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips_app/place/ui/screens/add_new_place.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'circle_button.dart';


class ButtonsBar extends StatelessWidget {
UserBLoc userBLoc;
  @override
  Widget build(BuildContext context) {
    userBLoc = BlocProvider.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 10.0
        ),
        child: Row(
          children: <Widget>[
            //cambiar la cntraseña
            CircleButton(true, Icons.vpn_key, 20.0, Color.fromRGBO(255, 255, 255, 0.6),
            ()=>{}),
            //añadir lugar
            CircleButton(false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1),
            (){
             
              final picker = ImagePicker();

              picker.getImage(source: ImageSource.camera).then((PickedFile image) {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (BuildContext context) => addNewPlaceScreen(image: File(image.path))));
              }).catchError((onError) => print(onError));
            }),
            //cerrar sesion
            CircleButton(true, Icons.exit_to_app, 20.0, Color.fromRGBO(255, 255, 255, 0.6),
            ()=>{userBLoc.signOut()}),
            
          ],
        )
    );
  }

}