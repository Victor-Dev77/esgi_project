import 'package:esgi_project/api/firebase_storage_api.dart';
import 'package:get/get.dart';

class FirebaseStorageRepository {

  static FirebaseStorageRepository get to => Get.put(FirebaseStorageRepository());

  final FirebaseStorageAPI _storageAPI = FirebaseStorageAPI();

  Future<String> uploadPicture(String path) async {
    return await _storageAPI.uploadPicture(path);
  }

}
