// ignore_for_file: sdk_version_async_exported_from_core

import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/place/model/place.dart';
import 'package:platzi_trips_app/user/model/user.dart' as UserModel;
import 'package:platzi_trips_app/user/repository/auth_repository.dart';
import 'package:platzi_trips_app/user/repository/firestore_repository.dart';
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



  @override
  void dispose() {
    
  }
  
}