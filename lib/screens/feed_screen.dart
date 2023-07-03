import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/colors.dart';

import 'package:social_app/widgets/post_card.dart';
import 'package:social_app/utils/global_variable.dart';

class FeedScreen extends StatelessWidget {

  const FeedScreen({super.key,});


  @override
  Widget build(BuildContext context) {
    bool  _isLoading = false;
           
    return     Scaffold(
      backgroundColor:
  
         MediaQuery.of(context).size.width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar:MediaQuery.of(context).size.width  > webScreenSize
          ? null
          : AppBar(
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                colorFilter: const ColorFilter.matrix([
                  -1,
                  0,
                  0,
                  0,
                  255,
                  0,
                  -1,
                  0,
                  0,
                  255,
                  0,
                  0,
                  -1,
                  0,
                  255,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                height: 32,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.messenger_outline),
                ),
              ],
            ),
      body:StreamBuilder(
        stream : FirebaseFirestore.instance.collection('posts').snapshots(),
         builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, Index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width  > webScreenSize ? MediaQuery.of(context).size.width  * 0.3 : 0,
                vertical: MediaQuery.of(context).size.width  > webScreenSize ?15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[Index].data(),
              ),
            ),
          );
        }, 
      ),
    );
  }
}
