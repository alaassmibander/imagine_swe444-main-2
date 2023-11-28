import 'package:cloud_firestore/cloud_firestore.dart';

class usermodel {
  final String? id;
  String username; // Can be updated
  String email;    // Can be updated
  String imgURL;   // Can be updated

  usermodel({
    this.id,
    required this.email,
    required this.imgURL,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'image_url': imgURL,
      'username': username,
    };
  }

  factory usermodel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return usermodel(
      id: document.id,
      email: data["email"],
      imgURL: data["image_url"],
      username: data["username"],
    );
  }
}
