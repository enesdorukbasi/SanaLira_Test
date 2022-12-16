import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLocal {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;

  UserLocal({
    required this.id,
    this.name = "",
    this.surname = "",
    required this.email,
    this.phoneNumber = "",
  });

  factory UserLocal.createUserByFirebase(User? user) {
    return UserLocal(id: user!.uid, email: user.email.toString());
  }

  factory UserLocal.createUserByDoc(DocumentSnapshot doc) {
    return UserLocal(
      id: doc.id,
      name: doc.get("name"),
      surname: doc.get("surname"),
      email: doc.get("email"),
      phoneNumber: doc.get("phoneNumber"),
    );
  }
}
