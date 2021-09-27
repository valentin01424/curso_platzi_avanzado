import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/repository/auth_repository.dart';
class UserBLoc implements Bloc{
 
  // ignore: non_constant_identifier_names
  final _auth_repository = AuthRepository();
 
 //casos de uso
 // signin App Google
 
Future<UserCredential> signIn(){
  return _auth_repository.signInFirebase();

 }
 
 
  @override
  void dispose() {
    
  }
  
}