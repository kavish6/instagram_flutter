import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/comment.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import '../models/post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(String caption, Uint8List file, String uid,
      String username, String profileImage) async {
    String res = 'some error occured';
    try {
      String postId = const Uuid().v1();
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      Post post = Post(
          uid: uid,
          caption: caption,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profileImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadComment(
    String commentText,
    String postId,
    String uid,
    String username,
    String profImage,
  ) async {
    if (commentText.isNotEmpty) {
      try {
        String commentId = const Uuid().v1();
        Comment comment = Comment(
            commentText: commentText,
            username: username,
            uid: uid,
            likes: [],
            datePublished: DateTime.now(),
            profImage: profImage,
            commentId: commentId,
            postId: postId);
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toJson());
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      DocumentReference ref = _firestore.collection('posts').doc(postId);
      await ref.delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
