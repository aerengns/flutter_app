import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_or_drunk_app/models/booking_model.dart' as booking_model;
import 'package:drive_or_drunk_app/models/booking_model.dart' show Booking;
import 'package:drive_or_drunk_app/models/event_model.dart' as event_model;
import 'package:drive_or_drunk_app/models/event_model.dart' show Event;
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

  Future<void> deleteUser(String id) async {
    return user_model.deleteUser(id, _db);
  }

  // EVENT METHODS
  Future<void> addEvent(Event event) async {
    return event_model.addEvent(event, _db);
  }

  Future<Event?> getEvent(String id) async {
    return event_model.getEvent(id, _db);
  }

  Stream<List<Event>> getEvents() {
    return event_model.getEvents(_db);
  }

  Future<void> updateEvent(String id, Map<String, dynamic> data) async {
    return event_model.updateEvent(id, data, _db);
  }

  Future<void> deleteEvent(String id) async {
    return event_model.deleteEvent(id, _db);
  }

  Future<void> addDriverToEvent(
      String eventId, DocumentReference<User> driverRef) async {
    return event_model.addDriver(eventId, driverRef, _db);
  }

  Future<void> addDrunkardToEvent(
      String eventId, DocumentReference<User> drunkardRef) async {
    return event_model.addDrunkard(eventId, drunkardRef, _db);
  }

  Future<void> removeDriverFromEvent(
      String eventId, DocumentReference<User> driverRef) async {
    return event_model.removeDriver(eventId, driverRef, _db);
  }

  Future<void> removeDrunkardFromEvent(
      String eventId, DocumentReference<User> drunkardRef) async {
    return event_model.removeDrunkard(eventId, drunkardRef, _db);
  }

  // BOOKING METHODS
  Future<void> addBooking(Booking booking) async {
    return booking_model.addBooking(booking, _db);
  }

  Future<Booking?> getBooking(String id) async {
    return booking_model.getBooking(id, _db);
  }

  Stream<List<Booking>> getBookings() {
    return booking_model.getBookings(_db);
  }

  Future<void> updateBooking(String id, Map<String, dynamic> data) async {
    return booking_model.updateBooking(id, data, _db);
  }

  Future<void> deleteBooking(String id) async {
    return booking_model.deleteBooking(id, _db);
  }

  Future<void> addDrunkardToBooking(
      String bookingId, DocumentReference<User> drunkardRef) async {
    return booking_model.addDrunkard(bookingId, drunkardRef, _db);
  }

  Future<void> removeDrunkardFromBooking(
      String bookingId, DocumentReference<User> drunkardRef) async {
    return booking_model.removeDrunkard(bookingId, drunkardRef, _db);
  }
}
