import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/place/model/place.dart';

import 'package:platzi_trips_app/user/model/user.dart';
import 'cloud_firestore_api.dart';

class FirestoreReposiroy {
  final _FirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _FirestoreAPI.updateUserData(user);
  Future<void> updatePlaceDate(Place place) => _FirestoreAPI.updatePlaceDate(place);
}