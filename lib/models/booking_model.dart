import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, FirebaseFirestore;
import 'package:drive_or_drunk_app/config/constants.dart' show Collections;

class Booking {
  final String? id;
  final DocumentReference eventId;
  final DocumentReference? driverId;
  final List<DocumentReference> drunkards;

  Booking(
      {this.id,
      required this.eventId,
      this.driverId,
      this.drunkards = const []});

  factory Booking.fromMap(Map<String, dynamic> data, String documentId) {
    return Booking(
      id: documentId,
      eventId: data['eventId'],
      driverId: data['driverId'],
      drunkards: List<DocumentReference>.from(data['drunkards'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'driverId': driverId,
      'drunkards': drunkards,
    };
  }
}

Future<void> addBooking(Booking booking, FirebaseFirestore db) async {
  if (booking.id == null) {
    db.collection(Collections.bookings).add(booking.toMap());
  } else {
    await db
        .collection(Collections.bookings)
        .doc(booking.id)
        .set(booking.toMap());
  }
}

Future<Booking?> getBooking(String id, FirebaseFirestore db) async {
  final doc = await db.collection(Collections.bookings).doc(id).get();
  if (doc.exists) {
    return Booking.fromMap(doc.data()!, doc.id);
  }
  return null;
}

Stream<List<Booking>> getBookings(FirebaseFirestore db) {
  return db.collection(Collections.bookings).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Booking.fromMap(doc.data(), doc.id)).toList());
}

Future<void> updateBooking(
    String id, Map<String, dynamic> data, FirebaseFirestore db) async {
  await db.collection(Collections.bookings).doc(id).update(data);
}

Future<void> deleteBooking(String id, FirebaseFirestore db) async {
  await db.collection(Collections.bookings).doc(id).delete();
}

Future<void> addDrunkard(String bookingId, DocumentReference drunkardRef,
    FirebaseFirestore db) async {
  final booking = await getBooking(bookingId, db);
  if (booking != null) {
    booking.drunkards.add(drunkardRef);
    await updateBooking(bookingId, {'drunkards': booking.drunkards}, db);
  }
}

Future<void> removeDrunkard(String bookingId, DocumentReference drunkardRef,
    FirebaseFirestore db) async {
  final booking = await getBooking(bookingId, db);
  if (booking != null) {
    booking.drunkards.remove(drunkardRef);
    await updateBooking(bookingId, {'drunkards': booking.drunkards}, db);
  }
}
