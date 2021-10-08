import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/user/model/user.dart' as Model;

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
   
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(Model.User user) async{
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return ref.set({
        "uid": user.uid,
        "name": user.name,
        "email": user.email,
        "photoURL": user.photoURL,
        "myPlaces": user.myPlaces,
        "myFacoritePlaces": user.myFavoritePlaces,
        "lastSignIn": DateTime.now(),
      },SetOptions(merge: true));
  }
Future<void> updatePlaceDate(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    //Este método va a generar un identificador unico y autoincremental
    User user = _auth.currentUser;
    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': "${USERS}/${user.uid}"//tipo de dato conocido como reference
    });
    }
  }

