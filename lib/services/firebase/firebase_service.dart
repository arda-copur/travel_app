import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/models/user_profile.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile(
      String uid, String? fullName, String? email) async {
    final userRef = _firestore.collection('users').doc(uid);
    final docSnapshot = await userRef.get();

    if (!docSnapshot.exists) {
      await userRef.set({
        'fullName': fullName,
        'email': email,
        'createdAt': Timestamp.now(),
        'lastLogin': Timestamp.now(),
      });
    } else {
      await userRef.update({
        'lastLogin': Timestamp.now(),
      });
    }
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserProfile.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUserProfile(String uid, String fullName) async {
    await _firestore.collection('users').doc(uid).update({
      'fullName': fullName,
    });
  }
}
