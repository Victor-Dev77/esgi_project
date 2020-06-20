import 'dart:io';
import 'package:esgi_project/controllers/add_event_controller.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as i;

class FirebaseStorageAPI {

  Future<String> uploadPicture(String path) async {
    return await _uploadFile(await _compressimage(File(path)));
  }

  Future _compressimage(File image) async {
    final tempdir = await getTemporaryDirectory();
    final path = tempdir.path;
    i.Image imagefile = i.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path.jpg')
      ..writeAsBytesSync(i.encodeJpg(imagefile, quality: 80));
    return compressedImagefile;
  }

  Future<String> _uploadFile(File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('events/${UserController.to.user.id}/${AddEventController.to.event.id}/pic_${image.hashCode}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    if (uploadTask.isInProgress == true) {}
    if (await uploadTask.onComplete != null) { 
      return await storageReference.getDownloadURL();
    }
    print("uploadfile: return null");
    return null;
  }

}