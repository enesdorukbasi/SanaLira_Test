import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(
      {id, email, phoneNumber, username, name, surname, photoUrl = ""}) async {
    try {
      await _firestore.collection("users").doc(id).set({
        "name": name,
        "surname": surname,
        "email": email,
        "phoneNumber": phoneNumber
      });
    } catch (ex) {
      print(ex);
    }
  }
}
