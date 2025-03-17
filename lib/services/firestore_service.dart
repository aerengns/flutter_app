import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_or_drunk_app/models/user_model.dart';

class Collections {
  static const String users = 'User';
  static const String bookings = 'Booking';
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    if (user.id == null) {
      _db.collection(Collections.users).add(user.toMap());
    } else {
      await _db.collection(Collections.users).doc(user.id).set(user.toMap());
    }
  }

  Future<User?> getUser(String id) async {
    final doc = await _db.collection(Collections.users).doc(id).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Stream<List<User>> getUsers() {
    return _db.collection(Collections.users).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    await _db.collection(Collections.users).doc(id).update(data);
  }

  Future<void> deleteUser(String? id) async {
    if (id == null) {
      // TODO: Handle error
      return;
    }
    await _db.collection(Collections.users).doc(id).delete();
  }
}
