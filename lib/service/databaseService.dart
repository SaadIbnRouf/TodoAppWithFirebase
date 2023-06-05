import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/users.dart';

class FirebaseService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference getCollectionReference() {
    return FirebaseService.db
        .collection("users")
        .doc(Users().getID())
        .collection("todo");
  }
}
