import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/user/repository/auth_repository.dart';
class UserBLoc implements Bloc{
 
  
  final authRepository = AuthRepository();
 
  //flujo de datos Streams
  //stream - firebase
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;



 //casos de uso
 // signin App Google
Future<UserCredential> signIn(){
  return authRepository.signInFirebase();

 }
 
 
  @override
  void dispose() {
    
  }
  
}