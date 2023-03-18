import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:livescore_repository/livescore_repository.dart';
import 'package:livescore_repository/src/models/league.dart';
import 'package:ozare_repository/src/features/bet/models/models.dart';
import 'package:ozare_repository/src/features/chat/models/models.dart';

class DashRepository {
  DashRepository({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  /// Get Stream of User's Bets
  Stream<List<Bet>> liveBetStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('bets')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Bet.fromJson(doc.data())).toList()
        ..sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
        );
    });
  }

  /// Sets the livescore data
  Future<void> saveLeagues(String category, List<League> leagues) async {
    final collection =
        _firestore.collection('leagues').doc(category).collection('temporary');
    for (final league in leagues) {
      final doc = collection.doc(league.id);
      await doc.set({
        'name': league.name,
        'events': league.events
            .map(
              (event) => {
                'id': event.id,
                'id1': event.id1,
                'id2': event.id2,
                'score1': event.score1,
                'score2': event.score2,
                'team1': event.team1,
                'team2': event.team2,
                'time': event.time,
                'logo1': event.logo1,
                'logo2': event.logo2,
                'category': event.category,
              },
            )
            .toList(),
        'createdAt': FieldValue.serverTimestamp()
      });
    }
  }

  /// Gets the livescore data.
  Future<List<League>?> getLeagues(
    String category, {
    required int refresherInMinutes,
  }) async {
    final collection =
        _firestore.collection('leagues').doc(category).collection('temporary');

    final snapshot = await collection.get();
    final currentTime = DateTime.now().toUtc();

    final leagues = <League>[];

    for (final doc in snapshot.docs) {
      final leagueData = doc.data();

      final createdAt = leagueData['createdAt'].toDate().toUtc() as DateTime;
      final difference = currentTime.difference(createdAt);

      /// the document is earlier  [refresherInMinutes] minutes, add it.
      if (difference.inMinutes <= refresherInMinutes) {
        final league = League(
          id: doc.id,
          name: leagueData['name'].toString(),
          events: (leagueData['events'] as List<dynamic>)
              .map(
                (eventData) => Event(
                  id: eventData['id'].toString(),
                  id1: eventData['id1'].toString(),
                  id2: eventData['id2'].toString(),
                  score1: eventData['score1'].toString(),
                  score2: eventData['score2'].toString(),
                  team1: eventData['team1'].toString(),
                  team2: eventData['team2'].toString(),
                  time: eventData['time'].toString(),
                  logo1: eventData['logo1'].toString(),
                  logo2: eventData['logo2'].toString(),
                  category: eventData['category'].toString(),
                ),
              )
              .toList(),
        );
        leagues.add(league);
        continue;
      }
    }

    if (leagues.isEmpty) {
      return null;
    }

    return leagues;
  }
}
