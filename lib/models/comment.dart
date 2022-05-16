import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentText;
  final String username;
  final String uid;
  final datePublished;
  final likes;
  final profImage;
  final String commentId;
  final String postId;
  Comment(
      {required this.commentText,
      required this.username,
      required this.uid,
      required this.likes,
      required this.datePublished,
      required this.profImage,
      required this.commentId,
      required this.postId});
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "commentText": commentText,
        "username": username,
        "commentId": commentId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "postId": postId
      };
  static Comment fromSnap(DocumentSnapshot snap) {
    var ds = snap.data() as Map<String, dynamic>;
    return Comment(
        uid: ds['uid'],
        commentText: ds['commentText'],
        username: ds['username'],
        commentId: ds['commentId'],
        datePublished: ds['datePublished'],
        profImage: ds['profImage'],
        likes: ds['likes'],
        postId: ds['postId']);
  }
}
