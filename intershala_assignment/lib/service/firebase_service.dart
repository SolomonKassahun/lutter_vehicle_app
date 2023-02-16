import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static Future<String> loadImage(String image, String folderName) async {
    // ignore: avoid_print
    print("image is in loading");
    try {
      Reference ref =  FirebaseStorage.instance.ref(folderName).child(image);
      var url = await ref.getDownloadURL();
      print("URL: $url");
      return url;
    } catch (e) {
      print("exceptin is $e");
      throw ("$e");
    }
  }

  
}
