import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:drive_or_drunk_app/config/constants.dart' show Collections;

class User {
  final String? id;
  final String name;
  final String username;
  final bool isVerified;
  final String? profilePicture;

  User(
      {this.id,
      required this.name,
      this.isVerified = false,
      required this.username,
      this.profilePicture});

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      id: documentId,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      isVerified: data['isVerified'] ?? false,
      profilePicture: data['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'isVerified': isVerified,
      'profilePicture': profilePicture,
    };
  }
}

Future<void> addUser(User user, FirebaseFirestore db) async {
  if (user.id == null) {
    db.collection(Collections.users).add(user.toMap());
  } else {
    await db.collection(Collections.users).doc(user.id).set(user.toMap());
  }
}

Future<User?> getUser(String id, FirebaseFirestore db) async {
  final doc = await db.collection(Collections.users).doc(id).get();
  if (doc.exists) {
    return User.fromMap(doc.data()!, doc.id);
  }
  return null;
}

Stream<List<User>> getUsers(FirebaseFirestore db) {
  return db.collection(Collections.users).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => User.fromMap(doc.data(), doc.id)).toList());
}

Future<void> updateUser(
    String id, Map<String, dynamic> data, FirebaseFirestore db) async {
  await db.collection(Collections.users).doc(id).update(data);
}

Future<void> deleteUser(String? id, FirebaseFirestore db) async {
  if (id == null) {
    log('Delete user called with null id');
    // TODO: Handle error
    return;
  }
  await db.collection(Collections.users).doc(id).delete();
}
