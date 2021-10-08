import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/place/ui/widgets/input_location.dart';
import 'package:platzi_trips_app/place/ui/widgets/text_input.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:platzi_trips_app/widgets/button_purple.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/title_header.dart';

class addNewPlaceScreen extends StatefulWidget {
  File image;
  addNewPlaceScreen({Key key, this.image});

  @override
  _addNewPlaceScreenState createState() => _addNewPlaceScreenState();
}

class _addNewPlaceScreenState extends State<addNewPlaceScreen> {
  @override
  Widget build(BuildContext context) {
     UserBLoc userBLoc = BlocProvider.of<UserBLoc>(context);

     final _controllerTitlePlace = TextEditingController();
     final _controllerDesPlace = TextEditingController();
     

    return Scaffold(
      body: Stack(
          children: [
            GradientBack(altura: 300),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only( top: 20, left: 5),
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: IconButton(
                      onPressed: (){
                          Navigator.pop(context);
                      }, 
                      icon: Icon(Icons.keyboard_arrow_left,color: Colors.white,size: 45,)),
                  ),

                ),
                Flexible(
                  child: Container(
                  padding: EdgeInsets.only(left: 20, top: 45, right: 10),
                  child:TitleHeader(title: "Añade tu nuevo lugar favorito",) ,)
                  ),

              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 120,bottom: 20),
              child: ListView(
                children: <Widget>[
                  Container(//foto
                    alignment: Alignment.center,
                    child: CardImage(
                      pathImage: widget.image.path,
                      iconData: Icons.camera_alt,
                      width: 320,
                      height: 250, 
                      left: 0,
                      onPressedFabIcon: () {  },
                      ),

                  ),
                  Container(//textfield title
                    margin: EdgeInsets.only(
                      bottom: 20,
                      top: 30),
                    child: TextInput(
                      hintText: "Titulo",
                      inputType: null,
                      maxLines: 1,
                      controller: _controllerTitlePlace,
                    ),

                  ),
                  TextInput(
                    hintText: "Descripcion",
                    inputType: TextInputType.multiline,
                    maxLines: 4,
                    controller: _controllerDesPlace,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextInputLocation(hintText: "Añade una ubicacion",iconData: Icons.location_on,) ,
                  ),
                  Container(
                    width: 70,
                    child: ButtonPurple(
                      buttonText:"Añadir lugar",
                      onPressed: (){
                        //1.firebase storage
                        //url
                        //2. clud firestore
                        //place - title, descrip, url IMG, userOwner, likes 
                         userBLoc.updatePlaceDate(Place(
                           name: _controllerTitlePlace.text,
                           description: _controllerDesPlace.text,
                           likes: 0,

                         )).whenComplete((){
                           print("TERMINADO");
                           Navigator.pop(context);
                         });

                      },
                      ),
                  )
                ],
              ),
            )
          ],
      ),
    );
  }
}