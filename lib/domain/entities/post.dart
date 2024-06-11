import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String content;
  final String? mediaUrl;
  final DateTime? timestamp;
  final String userId;
  final String userName;
  final String userEmail;
  final String? mediaType;  // Add this line

  Post({
    required this.id,
    required this.content,
    this.mediaUrl,
    this.timestamp,
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.mediaType,  // Initialize here
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      content: data['content'] ?? '',
      mediaUrl: data['mediaUrl'],
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? 'Anonymous',
      userEmail: data['userEmail'] ?? 'no-email@provided.com',
      mediaType: data['mediaType'],  // Make sure this field exists in Firestore
    );
  }
}
