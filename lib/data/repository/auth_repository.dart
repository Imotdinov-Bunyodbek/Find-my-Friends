import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_friend/data/model/my_hive.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

import '../model/user.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();

  AuthRepository._internal();

  factory AuthRepository() => _authRepository;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final currentUser = MyHiveHelper().getUser();

  Future<List<User>> getUsers() async {
    QuerySnapshot snapshot = await firestore
        .collection('user')
        .where('email', isNotEqualTo: currentUser.email)
        .get();

    return snapshot.docs
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<bool> signUp(User user) async {
    try {
      await firestore.collection('user').add(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(User user) async {
    try {
      await firestore.collection('user').doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImage(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));
    late File compressedFile;
    if (originalImage != null) {
      img.Image resizedImage =
          img.copyResize(originalImage, width: 256, height: 256);
      List<int> compressedImage = img.encodeJpg(resizedImage, quality: 80);
      compressedFile =
          File('${image.parent.path}/${image.uri.pathSegments.last}');
      compressedFile.writeAsBytesSync(compressedImage);
    }
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child('user_image/${compressedFile.uri.pathSegments.last}');
      await ref.putFile(compressedFile);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Failed to upload image: $e');
      return "";
    }
  }
}
