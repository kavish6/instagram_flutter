import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;
  const User(
      {required this.username,
      required this.uid,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following,
      required this.photoUrl});
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "photurl": photoUrl,
      };
  static User fromSnap(DocumentSnapshot snap) {
    var ds = snap.data() as Map<String, dynamic>;
    return User(
        username: ds['username'],
        photoUrl: ds['photurl'],
        bio: ds['bio'],
        uid: ds['uid'],
        email: ds['email'],
        followers: ds['followers'],
        following: ds['following']);
  }
}
