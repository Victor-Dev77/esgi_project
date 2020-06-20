import 'package:esgi_project/api/firebase_storage_api.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';

class FirebaseStorageRepository {

  static FirebaseStorageRepository get to => Get.put(FirebaseStorageRepository());

  final FirebaseStorageAPI _storageAPI = FirebaseStorageAPI();

  Future<String> uploadPicture(String idUser, String idDoc, String path) async {
    return await _storageAPI.uploadPicture(idUser, idDoc, path);
  }

  deleteEvent({@required String idUser, @required String idDoc, @required List<String> pictures}) async {
    await _storageAPI.deleteEvent(idUser, idDoc, pictures);
  }

}
