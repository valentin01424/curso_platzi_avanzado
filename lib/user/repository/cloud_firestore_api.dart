

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/user/model/user.dart' as Model;
import 'package:platzi_trips_app/user/ui/widgets/profile_place.dart';

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
      'userOwner': _db.doc("${USERS}/${user.uid}"),//tipo de dato conocido como reference
      'urlimage': place.urlImage
    }).then((DocumentReference dr){
    dr.get().then((DocumentSnapshot snapshot){
        //snapshot.id;//id referencia array
        DocumentReference refUser = _db.collection(USERS).doc(user.uid);
        refUser.update({
           'myPlaces': FieldValue.arrayUnion([ _db.doc("${PLACES}/${snapshot.id}")])
        });
          
    });
    });
    }
     List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot){
       List<ProfilePlace> profilePlaces = [];
       placesListSnapshot.forEach((p) { 
          profilePlaces.add(ProfilePlace(
            Place(
              description: p['description'] ,
              name:p['name'],
              urlImage:p['urlimage'],
              likes: p['likes'],
              ) 
              )
          );
       });
       return profilePlaces;
     }
  }

