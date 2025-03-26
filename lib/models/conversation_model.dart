import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_or_drunk_app/config/constants.dart';
import 'package:flutter/cupertino.dart' show debugPrint;

class Message {
  final String text;
  final Timestamp timestamp;
  final DocumentReference sender;

  Message({required this.text, required this.timestamp, required this.sender});

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      text: data['text'],
      timestamp: data['timestamp'],
      sender: data['sender'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp,
      'sender': sender,
    };
  }
}

class Conversation {
  final String? id;
  final DocumentReference user1;
  final DocumentReference user2;
  final List<Message> messageHistory;

  Conversation(
      {this.id,
      required this.user1,
      required this.user2,
      this.messageHistory = const []});

  factory Conversation.fromMap(Map<String, dynamic> data, String documentId) {

    return Conversation(
      id: documentId,
      user1: data['user1'],
      user2: data['user2'],
      messageHistory: List<Message>.from(data['messageHistory'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user1': user1,
      'user2': user2,
      'messageHistory': messageHistory,
    };
  }

  List<DocumentReference> getParticipants() {
    return [user1, user2];
  }
}

Future<void> addConversation(
    Conversation conversation, FirebaseFirestore db) async {
  if (conversation.id == null) {
    db.collection(Collections.conversations).add(conversation.toMap());
  } else {
    await db
        .collection(Collections.conversations)
        .doc(conversation.id)
        .set(conversation.toMap());
  }
}

Future<Conversation?> getConversation(String id, FirebaseFirestore db) async {
  final doc = await db.collection(Collections.conversations).doc(id).get();
  if (doc.exists) {
    return Conversation.fromMap(doc.data()!, doc.id);
  }
  return null;
}

Stream<List<Conversation>> getConversations(FirebaseFirestore db) {
  return db.collection(Collections.conversations).snapshots().map((snapshot) =>
      snapshot.docs
          .map((doc) => Conversation.fromMap(doc.data(), doc.id))
          .toList());
}

Future<void> updateConversation(
    String id, Map<String, dynamic> data, FirebaseFirestore db) async {
  await db.collection(Collections.conversations).doc(id).update(data);
}

Future<void> deleteConversation(String id, FirebaseFirestore db) async {
  await db.collection(Collections.conversations).doc(id).delete();
}

Future<void> addMessage(
    String conversationId, Message message, FirebaseFirestore db) async {
  final conversationRef =
      db.collection(Collections.conversations).doc(conversationId);
  final conversation = await conversationRef.get();
  if (conversation.exists) {
    final messageHistory =
        List<Message>.from(conversation.data()!['messageHistory'] ?? []);
    messageHistory.add(message);
    await conversationRef.update({'messageHistory': messageHistory});
  }
}
