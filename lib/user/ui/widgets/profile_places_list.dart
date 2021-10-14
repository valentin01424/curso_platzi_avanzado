import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:platzi_trips_app/user/model/user.dart';
import 'package:platzi_trips_app/user/ui/widgets/profile_place.dart';
import 'package:platzi_trips_app/place/model/place.dart';

class ProfilePlacesList extends StatelessWidget {
  UserBLoc userBLoc;
  User user;
  ProfilePlacesList(@required this.user);
  
  @override
  Widget build(BuildContext context) {
    userBLoc = BlocProvider.of<UserBLoc>(context);
    return Container(
        margin:
            EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
        child: StreamBuilder(
          stream: userBLoc.placesStream,
          
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return Column(
                  children: userBLoc.buildPlaces(snapshot.data.docs),
                );
              case ConnectionState.active:
                return Column(
                  children: userBLoc.buildPlaces(snapshot.data.docs),
                );
              case ConnectionState.none:
              return CircularProgressIndicator();
              default: return Column(
                  children: userBLoc.buildPlaces(snapshot.data.docs),
                );
            }
          },
        ));
  }
  /*
  Column(
        children: <Widget>[
          ProfilePlace(place),
          ProfilePlace(place2),
        ],
      ),
  */

}
