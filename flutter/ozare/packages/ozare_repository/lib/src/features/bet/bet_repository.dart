import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ozare_repository/src/features/bet/models/models.dart';

class BetRepository {
  BetRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Creates new Bet in current event
  Future<void> createBet({
    required Bet bet,
  }) async {
    // Add bet to event collection in firestore
    await _firestore
        .collection('events')
        .doc(bet.eventId)
        .collection('bets')
        .doc(bet.id)
        .set(bet.toJson());

    // Add bet to user collection in firestore
    await _firestore
        .collection('users')
        .doc(bet.userId)
        .collection('bets')
        .doc(bet.id)
        .set(bet.toJson());

    // add notification to user
    await _firestore
        .collection('users')
        .doc(bet.userId)
        .collection('notification')
        .doc()
        .set(bet.toJson());
  }

  // Get all bets in current event
  Stream<List<Bet>> betStream(String eventId) {
    return _firestore
        .collection('events')
        .doc(eventId)
        .collection('bets')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Bet.fromJson(doc.data())).toList(),
        );
  }
}
