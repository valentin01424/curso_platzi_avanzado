import 'package:flutter/material.dart';
import 'package:platzi_trips_app/user/ui/widgets/profile_place.dart';
import 'package:platzi_trips_app/place/model/place.dart';


class ProfilePlacesList extends StatelessWidget {

  Place place = Place(
    name: 'Knuckles Mountains ad', 
    description: 'Hiking. Water fall hunting. Natural bath', 
    urlImage: 'https://aws.admagazine.com/prod/designs/v1/assets/1260x630/61935.jpg', 
    likes: 3, 
    );
  Place place2 = Place(
    name: 'Mountains', 
    description: 'Hiking. Water fall hunting. Natural bath', 
    urlImage: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80', 
    likes: 8, 
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 10.0,
          left: 20.0,
          right: 20.0,
          bottom: 10.0
      ),
      child: Column(
        children: <Widget>[
          ProfilePlace(place),
          ProfilePlace(place2),
        ],
      ),
    );
  }

}