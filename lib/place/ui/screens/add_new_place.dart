import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
                padding: EdgeInsets.only(top: 20, left: 5),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 45,
                      )),
                ),
              ),
              Flexible(
                  child: Container(
                padding: EdgeInsets.only(left: 20, top: 45, right: 10),
                child: TitleHeader(
                  title: "Añade tu nuevo lugar favorito",
                ),
              )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120, bottom: 20),
            child: ListView(
              children: <Widget>[
                Container(
                  //foto
                  alignment: Alignment.center,
                  child: CardImage(
                    pathImage: widget.image.path,
                    iconData: Icons.camera_alt,
                    width: 320,
                    height: 250,
                    left: 0,
                    onPressedFabIcon: () {},
                  ),
                ),
                Container(
                  //textfield title
                  margin: EdgeInsets.only(bottom: 20, top: 30),
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
                  child: TextInputLocation(
                    hintText: "Añade una ubicacion",
                    iconData: Icons.location_on,
                  ),
                ),
                Container(
                  width: 70,
                  child: ButtonPurple(
                    buttonText: "Añadir lugar",
                    onPressed: () {
                      //ID del usuario logeado
                      userBLoc.currentUsuario().then((User user) {
                        if (user != null) {
                          String uid = user.uid;
                          String path = "$uid/${DateTime.now().toString()}.jpg";
                          //1.firebase storage
                          //url
                          userBLoc
                              .uploadFile(path, widget.image)
                              .then((UploadTask uploadTask) {
                            uploadTask.then((TaskSnapshot snapshot) {
                              snapshot.ref.getDownloadURL().then((urlImage) {
                                print("URL:${urlImage}");

                                //2. clud firestore
                                //place - title, descrip, url IMG, userOwner, likes
                                userBLoc
                                    .updatePlaceDate(Place(
                                  name: _controllerTitlePlace.text,
                                  description: _controllerDesPlace.text,
                                  urlImage: urlImage,
                                  likes: 0,
                                ))
                                    .whenComplete(() {
                                  Navigator.pop(context);
                                  print("TERMINADO");
                                });
                              });
                            });
                          });
                        }
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
