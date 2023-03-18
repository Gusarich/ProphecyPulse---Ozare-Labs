import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  EventRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  final FirebaseFirestore _firestore;

  // create new document with id of the event in events collection
  Future<void> initializeEvent(Map<String, dynamic> event) async {
    await _firestore
        .collection('events')
        .doc(event['id'].toString())
        .set(event);
  }
}
