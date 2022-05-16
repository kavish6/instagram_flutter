import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String caption;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;
  const Post(
      {required this.uid,
      required this.caption,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes});
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "caption": caption,
        "postUrl": postUrl,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes
      };
  static Post fromSnap(DocumentSnapshot snap) {
    var ds = snap.data() as Map<String, dynamic>;
    return Post(
        postUrl: ds['postUrl'],
        uid: ds['uid'],
        caption: ds['caption'],
        username: ds['username'],
        postId: ds['postId'],
        datePublished: ds['datePublished'],
        profImage: ds['profImage'],
        likes: ds['likes']);
  }
}
