import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors.dart';
import 'package:social_app/resources/firestore_method.dart';

import '../models/user.dart';
import '../poviders/user_provider.dart';
import '../widgets/commentCard.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .orderBy('datePublished',descending: true)
              .snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context,index)=>CommentCard(
                    snap:(snapshot.data! as dynamic).docs[index].data(),
                  ));
              },
              ),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding: const EdgeInsets.only(left: 16, right: 0),
        child: Row(children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user?.photoUrl ??''),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 8,
              ),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Comment as ${user?.username ?? ''}',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await FireStoreMethods().postComment(
                  widget.snap['postId'].toString(),
                  _commentController.text,
                  user?.uid ?? '',
                  user?.username ?? '',
                  user?.photoUrl ?? '');
                  setState(() {
                    _commentController.text="";
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ]),
      )),
    );
  }
}
