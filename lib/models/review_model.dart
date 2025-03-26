import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, FirebaseFirestore, Timestamp;
import 'package:drive_or_drunk_app/config/constants.dart' show Collections;
import 'package:flutter/cupertino.dart' show debugPrint;

class Comment {
  final DocumentReference author;
  final String text;
  final Timestamp? timestamp;
  final double rating;

  Comment(
      {required this.author,
      required this.text,
      this.timestamp,
      required this.rating});

  factory Comment.fromMap(Map<String, dynamic> data) {
    return Comment(
        author: data['author'],
        text: data['text'],
        timestamp: data['timestamp'] ?? Timestamp.now(),
        rating: data['rating']);
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'text': text,
      'timestamp': timestamp,
      'rating': rating,
    };
  }
}

class Review {
  final String? id;
  final DocumentReference author;
  final double stars;
  final List<Comment> comments;

  Review(
      {this.id,
      required this.author,
      required this.stars,
      this.comments = const []});

  factory Review.fromMap(Map<String, dynamic> data, String documentId) {
    return Review(
        id: documentId,
        author: data['author'],
        stars: data['stars'],
        comments: List<Comment>.from((data['comments'] as List<dynamic>? ?? [])
            .map((comment) => Comment.fromMap(comment))
            .toList()));
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'stars': stars,
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }
}

Future<void> addReview(Review review, FirebaseFirestore db) async {
  if (review.id == null) {
    db.collection(Collections.reviews).add(review.toMap());
  } else {
    await db.collection(Collections.reviews).doc(review.id).set(review.toMap());
  }
}

Future<Review?> getReview(String id, FirebaseFirestore db) async {
  final doc = await db.collection(Collections.reviews).doc(id).get();
  if (doc.exists) {
    return Review.fromMap(doc.data()!, doc.id);
  }
  return null;
}

Stream<List<Review>> getReviews(FirebaseFirestore db) {
  return db.collection(Collections.reviews).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Review.fromMap(doc.data(), doc.id)).toList());
}

Future<void> updateReview(
    String id, Map<String, dynamic> data, FirebaseFirestore db) async {
  debugPrint('updateReview: $id, $data');
  await db.collection(Collections.reviews).doc(id).update(data);
}

Future<void> deleteReview(String id, FirebaseFirestore db) async {
  await db.collection(Collections.reviews).doc(id).delete();
}

Future<void> addComment(
    String reviewId, Comment comment, FirebaseFirestore db) async {
  final review = await getReview(reviewId, db);
  if (review != null) {
    review.comments.add(comment);
    final Map<String, dynamic> reviewMap = review.toMap();
    await updateReview(
        reviewId, {...reviewMap, 'stars': review.stars + comment.rating}, db);
  }
}
