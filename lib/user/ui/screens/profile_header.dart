import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/bloc/bloc_user.dart';
import 'package:platzi_trips_app/user/model/user.dart';
import '../widgets/user_info.dart';
import '../widgets/button_bar.dart';

class ProfileHeader extends StatelessWidget {
  UserBLoc userBLoc;
  User user;
    @override
  Widget build(BuildContext context) {
   userBLoc = BlocProvider.of<UserBLoc>(context);
   
   return StreamBuilder(
     stream: userBLoc.streamFirebase,
     // ignore: missing_return
     builder: (BuildContext context, AsyncSnapshot snapshot){
       
                 switch (snapshot.connectionState) {
                     case ConnectionState.waiting:
                     case ConnectionState.none:
                     return CircularProgressIndicator();
                     case ConnectionState.active:
                     case ConnectionState.done:
                     return showProfileData(snapshot);

                   }
     },

   
   );
   }
  Widget showProfileData(AsyncSnapshot snapshot){
    if (!snapshot.hasData || snapshot.hasError) {
      print("no logeado");
      return  Container(
      margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
      ),
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(),
          Text("se produjo un error, logeate nuevamente")


        ]
      ),
    );
    }else{
      print("llogeado");

      user = User(
      name: snapshot.data.displayName ,
      email: snapshot.data.email ,
      photoURL: snapshot.data.photoURL, 
      
       );


      final title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
      ),
    );

    return Container(
      margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              title
            ],
          ),
          UserInfo(user),
          ButtonsBar()
        ],
      ),
    );
    }
  }
  
}