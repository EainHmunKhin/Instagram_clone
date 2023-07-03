// import 'dart:ffi';
// import 'dart:typed_data';

// import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String? profImage,
  ) async {
    String res = "some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage??'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC',
          likes: [],
          username: username,
          uid: uid,
          photoUrl: photoUrl);
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String? uid, List? likes) async {
    try {
      if (likes!.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postComment(String? postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'text': text,
        });
      } else {
        print("Please enter text");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //deleting the post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
  

  Future<void> followUser(
    String uid,
    String followId,
  ) async {
    try{
 DocumentSnapshot snap= await _firestore.collection('users').doc(uid).get();
 List following = (snap.data()! as dynamic)['following'];
 if(following.contains(followId)){
  await _firestore.collection('users').doc(followId).update({
 'followers': FieldValue.arrayRemove([uid]),
  });
    await _firestore.collection('users').doc(uid).update({
 'following': FieldValue.arrayRemove([uid]),
  });
 }else{
    await _firestore.collection('users').doc(followId).update({
 'followers': FieldValue.arrayUnion([uid]),
  });
    await _firestore.collection('users').doc(uid).update({
 'followers': FieldValue.arrayUnion([uid]),
  });
 }

 
    }catch(e){
      print(e.toString());
    }
  }
}
