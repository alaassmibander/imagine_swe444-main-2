import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagine_swe/authentication/models/usermodel.dart';

class user_repository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch All user or user details
  Future<usermodel> getUserDetails(String email) async {
    final snapshot = await _db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => usermodel.fromSnapshot(e)).single;
    return userData;
  }

  // Update user details
Future<void> updateUser(usermodel user) async {
    try {
      await _db.collection('users').doc(user.id).update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}
