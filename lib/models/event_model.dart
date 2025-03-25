import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, FirebaseFirestore, GeoPoint;
import 'package:drive_or_drunk_app/config/constants.dart' show Collections;
import 'package:drive_or_drunk_app/models/user_model.dart' show User;

class Event {
  final String? id;
  final String name;
  final List<DocumentReference> drivers;
  final List<DocumentReference> drunkards;
  final GeoPoint? location;

  Event(
      {this.id,
      required this.name,
      this.drivers = const [],
      this.drunkards = const [],
      this.location});

// THIS PART IS PROBABLY NOT NEEDED BUT JUST IN CASE I LEFT IT IN
  // factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options) {
  //   final data = snapshot.data();
  //   debugPrint('Event.fromFirestore: $data');
  //   return Event(
  //     name: data?['name'],
  //     drivers: data?['drivers'],
  //     drunkards: data?['drunkards'],
  //     location: data?['location'],
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     'name': name,
  //     'drivers': drivers,
  //     'drunkards': drunkards,
  //     if (location != null) 'location': location,
  //   };
  // }

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    return Event(
      id: documentId,
      name: data['name'] ?? '',
      drivers: List<DocumentReference>.from(data['drivers'] ?? []),
      drunkards: List<DocumentReference>.from(data['drunkards'] ?? []),
      location: data['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'drivers': drivers,
      'drunkards': drunkards,
      'location': location,
    };
  }
}

Future<void> addEvent(Event event, FirebaseFirestore db) async {
  if (event.id == null) {
    db.collection(Collections.events).add(event.toMap());
  } else {
    await db.collection(Collections.events).doc(event.id).set(event.toMap());
  }
}

Future<Event?> getEvent(String id, FirebaseFirestore db) async {
  final doc = await db.collection(Collections.events).doc(id).get();
  if (doc.exists) {
    return Event.fromMap(doc.data()!, doc.id);
  }
  return null;
}

Stream<List<Event>> getEvents(FirebaseFirestore db) {
  return db.collection(Collections.events).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Event.fromMap(doc.data(), doc.id)).toList());
}

Future<void> updateEvent(
    String id, Map<String, dynamic> data, FirebaseFirestore db) async {
  await db.collection(Collections.events).doc(id).update(data);
}

Future<void> deleteEvent(String id, FirebaseFirestore db) async {
  await db.collection(Collections.events).doc(id).delete();
}

Future<void> addDriver(String eventId, DocumentReference<User> driverRef,
    FirebaseFirestore db) async {
  final event = await getEvent(eventId, db);
  if (event != null) {
    event.drivers.add(driverRef);
    await updateEvent(eventId, {'drivers': event.drivers}, db);
  }
}

Future<void> addDrunkard(String eventId, DocumentReference<User> drunkardRef,
    FirebaseFirestore db) async {
  final event = await getEvent(eventId, db);
  if (event != null) {
    event.drunkards.add(drunkardRef);
    await updateEvent(eventId, {'drunkards': event.drunkards}, db);
  }
}

Future<void> removeDriver(String eventId, DocumentReference<User> driverRef,
    FirebaseFirestore db) async {
  final event = await getEvent(eventId, db);
  if (event != null) {
    event.drivers.remove(driverRef);
    await updateEvent(eventId, {'drivers': event.drivers}, db);
  }
}

Future<void> removeDrunkard(String eventId, DocumentReference<User> drunkardRef,
    FirebaseFirestore db) async {
  final event = await getEvent(eventId, db);
  if (event != null) {
    event.drunkards.remove(drunkardRef);
    await updateEvent(eventId, {'drunkards': event.drunkards}, db);
  }
}
