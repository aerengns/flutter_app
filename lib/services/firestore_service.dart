import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_or_drunk_app/models/user_model.dart' as user_model;
import 'package:drive_or_drunk_app/models/user_model.dart' show User;

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// USER METHODS
  Future<void> addUser(User user) async {
    return user_model.addUser(user, _db);
  }

  Future<User?> getUser(String id) async {
    return user_model.getUser(id, _db);
  }

  Stream<List<User>> getUsers() {
    return user_model.getUsers(_db);
  }

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    return user_model.updateUser(id, data, _db);
  }

  Future<void> deleteUser(String? id) async {
    return user_model.deleteUser(id, _db);
  }
}
