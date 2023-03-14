import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ozare_repository/src/features/chat/models/models.dart';

class ChatRepository {
  ChatRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  // Create new Chat in current event
  Future<void> sendChat(String eventId, Chat chat) async {
    await _firestore
        .collection('events')
        .doc(eventId)
        .collection('chat')
        .doc(chat.id)
        .set(chat.toJson());
  }

  // Get all chats in current event
  Stream<List<Chat>> chatStream(String eventId) {
    return _firestore
        .collection('events')
        .doc(eventId)
        .collection('chat')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Chat.fromJson(doc.data())).toList());
  }
}
