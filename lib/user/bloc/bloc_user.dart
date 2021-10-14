// ignore_for_file: sdk_version_async_exported_from_core

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips_app/user/model/user.dart' as UserModel;
import 'package:platzi_trips_app/user/repository/auth_repository.dart';
import 'package:platzi_trips_app/user/repository/cloud_firestore_api.dart';
import 'package:platzi_trips_app/user/repository/firestore_repository.dart';
import 'package:platzi_trips_app/user/ui/widgets/profile_place.dart';
class UserBLoc implements Bloc{
 
  
  final authRepository = AuthRepository();
 
  //flujo de datos Streams
  //stream - firebase
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;


    //Future<User> get currentUser => FirebaseAuth.instance.currentUser;
  Future<User> currentUsuario() async {
    User user = FirebaseAuth.instance.currentUser;
    return user;
  }



 //casos de uso
 // signin App Google
Future<UserCredential> signIn(){
  return authRepository.signInFirebase();

 }
 //cerrar sesion
 signOut(){
   authRepository.signOut();

 }
// registrar en db 
// creamos la entidad para llamar al metodo de esa entidad/clase
final _cloudFirestoreRepository = FirestoreReposiroy();
void updateUserData(UserModel.User user) => _cloudFirestoreRepository.updateUserDataFirestore(user); 
Future<void> updatePlaceDate(Place place) =>_cloudFirestoreRepository.updatePlaceDate(place);
//linea de abajo: con esa linea obtengo y escucho todo los cambios que ocuuren en mi base de datos, mas espesifacemnte en mi coleccion "places" todos los datos caen en esta linea stram
Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
Stream<QuerySnapshot> get placesStream => placesListStream;
List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

Stream<QuerySnapshot>  myPlacesListStream(String uid) => 
FirebaseFirestore.instance.collection(CloudFirestoreAPI().PLACES)
.where("userOwner", isEqualTo: FirebaseFirestore.instance.doc("${CloudFirestoreAPI().USERS}/${uid}"))
.snapshots();

final _firebaseStorageRepository =  FirebaseStorageRepositry();
Future<UploadTask> uploadFile(String path, File image) => _firebaseStorageRepository.uploadFile(path, image);

  @override
  void dispose() {
    
  }
  
}