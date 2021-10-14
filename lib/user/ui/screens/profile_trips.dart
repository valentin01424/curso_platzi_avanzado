import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:platzi_trips_app/user/model/user.dart';
import 'package:platzi_trips_app/user/ui/screens/profile_header.dart';
import '../widgets/profile_places_list.dart';
import '../widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {
  UserBLoc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBLoc>(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
          print("saffas");
          return CircularProgressIndicator();
          case ConnectionState.none:
          print("noonon");
          return CircularProgressIndicator();

          case ConnectionState.active:
          return showProfileData(snapshot);
          case ConnectionState.done:
          return showProfileData(snapshot);

          
          default:

        }

      }
      ); 
 

    // TODO: implement build
    /*return Container(
      color: Colors.indigo,
    );*/

    /*return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(),
            ProfilePlacesList()

          ],
        ),
      ],
    );*/
  }
  Widget showProfileData(AsyncSnapshot snapshot){
    if (!snapshot.hasData || snapshot.hasError ) {
      print("no logeado");
      return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            Text("no te haz logeado, logeate negri")

          ],
        ),
      ],
    );
    }else{
      print("logeado");
      var user = User(
        uid: snapshot.data.uid,
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoURL: snapshot.data.photoURL,
      );
      return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(user),
            ProfilePlacesList(user)

          ],
        ),
      ],
    );
      
    }
  }

}