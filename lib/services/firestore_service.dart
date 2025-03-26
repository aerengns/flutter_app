import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_or_drunk_app/models/booking_model.dart' as booking_model;
import 'package:drive_or_drunk_app/models/booking_model.dart' show Booking;
import 'package:drive_or_drunk_app/models/conversation_model.dart'
    as conversation_model;
import 'package:drive_or_drunk_app/models/conversation_model.dart'
    show Conversation;
import 'package:drive_or_drunk_app/models/event_model.dart' as event_model;
import 'package:drive_or_drunk_app/models/event_model.dart' show Event;
import 'package:drive_or_drunk_app/models/review_model.dart' as review_model;
import 'package:drive_or_drunk_app/models/review_model.dart' show Review;
import 'package:drive_or_drunk_app/models/user_model.dart' as user_model;
import 'package:drive_or_drunk_app/models/user_model.dart' show User;

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// ==================== USER METHODS ====================
  Future<void> addUser(User user) async {
    return user_model.addUser(user, _db);
  }

  Future<User?> getUser(String id) async {
    return user_model.getUser(id, _db);
  }

  Future<DocumentReference?> getUserReference(String id) async {
    return user_model.getUserReference(id, _db);
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

// ==================== EVENT METHODS ====================
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

// ==================== BOOKING METHODS ====================
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

// ==================== CONVERSATION METHODS ====================
  Future<void> addConversation(Conversation conversation) async {
    return conversation_model.addConversation(conversation, _db);
  }

  Future<Conversation?> getConversation(String id) async {
    return conversation_model.getConversation(id, _db);
  }

  Stream<List<Conversation>> getConversations() {
    return conversation_model.getConversations(_db);
  }

  Future<void> updateConversation(String id, Map<String, dynamic> data) async {
    return conversation_model.updateConversation(id, data, _db);
  }

  Future<void> deleteConversation(String id) async {
    return conversation_model.deleteConversation(id, _db);
  }

  Future<void> addMessageToConversation(
      String conversationId, conversation_model.Message message) async {
    return conversation_model.addMessage(conversationId, message, _db);
  }

// ==================== REVIEW METHODS ====================
  Future<void> addReview(Review review, User user) async {
     final reviewRef = await review_model.addReview(review, _db);
     user_model.addReview(reviewRef, user, _db);
  }

  Future<Review?> getReview(String id) async {
    return review_model.getReview(id, _db);
  }

  Stream<List<Review>> getReviews() {
    return review_model.getReviews(_db);
  }

  Future<void> updateReview(String id, Map<String, dynamic> data) async {
    return review_model.updateReview(id, data, _db);
  }

  Future<void> deleteReview(String id) async {
    return review_model.deleteReview(id, _db);
  }

  Future<void> addCommentToReview(
      String reviewId, review_model.Comment comment) async {
    return review_model.addComment(reviewId, comment, _db);
  }
}
