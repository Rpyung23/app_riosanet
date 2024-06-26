import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseUtils {
  static initialzeFirebase() async {
    /*options: FirebaseOptions(apiKey: "AIzaSyAU6ZhWNUntCGWCobdOTvpzRUDQG1DxzIU", 
    appId: "com.riosanet.riosanet", messagingSenderId: messagingSenderId, projectId: "riosanet-c51db") */
    await Firebase.initializeApp();
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  static Future<String> uploadUserImageToFireStorage(
      File image, String fileName) async {
    var uuid = Uuid();

    Reference upload =
        FirebaseStorage.instance.ref().child('fail/${uuid.v1()}');

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    UploadTask? uploadTask;
    print(image);

    uploadTask = upload.putFile(image);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          print("Handle unsuccessful uploads");
          break;
        case TaskState.success:
          print("Handle successful uploads on complete");
          // ...
          break;
      }
    });

    //return "";
    print("up start");

    var downloadUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    print("up start got url");

    return downloadUrl.toString();
  }

  static Future<String> uploadSignatureImageToFireStorage(
      File image, String fileName) async {
    var uuid = Uuid();

    Reference upload =
        FirebaseStorage.instance.ref().child('signature/${uuid.v1()}');

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    UploadTask? uploadTask;
    print(image);

    uploadTask = upload.putFile(image);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          print("Handle unsuccessful uploads");
          break;
        case TaskState.success:
          print("Handle successful uploads on complete");
          // ...
          break;
      }
    });

    //return "";
    print("up start");

    var downloadUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    print("up start got url");

    return downloadUrl.toString();
  }
}
