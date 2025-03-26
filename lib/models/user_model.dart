import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, FirebaseException, FirebaseFirestore;
import 'package:drive_or_drunk_app/config/constants.dart' show Collections;

class User {
  final String? id;
  final String name;
  final String username;
  final bool isVerified;
  final int age;
  final String? profilePicture;
  final List<DocumentReference> registeredEvents;
  final List<DocumentReference> favoriteEvents;
  // TODO: add a conversations field to the User model

  User({
    this.id,
    required this.name,
    this.isVerified = false,
    required this.age,
    required this.username,
    this.profilePicture,
    this.registeredEvents = const [],
    this.favoriteEvents = const [],
  });

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      id: documentId,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      isVerified: data['isVerified'] ?? false,
      age: data['age'] ?? 0,
      profilePicture: data['profilePicture'],
      registeredEvents:
          List<DocumentReference>.from(data['registeredEvents'] ?? []),
      favoriteEvents:
          List<DocumentReference>.from(data['favoriteEvents'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'isVerified': isVerified,
      'age': age,
      'profilePicture': profilePicture,
      'registeredEvents': registeredEvents,
      'favoriteEvents': favoriteEvents,
    };
  }
}

Future<DocumentReference?> getUserReference(
    String id, FirebaseFirestore db) async {
  return db.collection(Collections.users).doc(id);
}

Future<void> addUser(User user, FirebaseFirestore db) async {
  if (user.id == null) {
    db.collection(Collections.users).add(user.toMap());
  } else {
    throw FirebaseException(
      plugin: 'Firestore',
      message: 'A user with that ID already exists.',
    );
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

Future<void> deleteUser(String id, FirebaseFirestore db) async {
  await db.collection(Collections.users).doc(id).delete();
}
