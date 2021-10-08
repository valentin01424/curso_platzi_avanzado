import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:platzi_trips_app/place/repository/firebase_storage_api.dart';

class FirebaseStorageRepositry {
  final _firebaseStorageApi = FirebaseStorageApi();

  Future<UploadTask> uploadFile(String path, File image) => _firebaseStorageApi.uploadFile(path, image);
  
}