import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors.dart';
import 'package:social_app/resources/auth_method.dart';
import 'package:social_app/resources/firestore_method.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/utils/global_variable.dart';
import 'package:social_app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //get post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
      postLen = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['followers'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username'] ?? ''),
              centerTitle: false,
            ),
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // CircleAvatar(
                        //   backgroundColor: Colors.blue,
                        //   backgroundImage: NetworkImage(userData['photoUrl'] ??'https://tse1.mm.bing.net/th?id=OIP.Uwo-kkvTH_pEjCu0O4z7oQAAAA&pid=Api&rs=1&c=1&qlt=95&w=116&h=116'
                        //       ),
                        //   radius: 40,
                        // ),
                        ProfilePicture(
                          name: userData['username'] ?? '',
                          role: userData['bio']??'',
                          radius: 31,
                          fontsize: 21,
                          tooltip: true,
                        
                          img:   userData['photoUrl']??''),
                        
                      

                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize:
                                    MediaQuery.of(context).size.width >
                                            webScreenSize
                                        ? MainAxisSize.max
                                        : MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStatColumn(postLen, 'posts'),
                                  buildStatColumn(followers, 'followers'),
                                  buildStatColumn(following, 'following'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.uid
                                      ? Expanded(
                                          child: Expanded(
                                            child: FollowButton(
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                text: 'Sign Out',
                                                textColor: Colors.white,
                                                borderColor: Colors.grey,
                                                funtion: () async {
                                                  await AuthMethods().signOut();
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen(),
                                                  ));
                                                }),
                                          ),
                                        )
                                      : isFollowing
                                          ? Expanded(
                                              child: FollowButton(
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                text: 'Unfollow',
                                                textColor: Colors.white,
                                                borderColor: Colors.grey,
                                                funtion: () async {
                                                  await FireStoreMethods()
                                                      .followUser(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    userData['uid'],
                                                  );
                                                  setState(() {
                                                    isFollowing = false;
                                                    followers--;
                                                  });
                                                },
                                              ),
                                            )
                                          : isFollowing
                                              ? Expanded(
                                                  child: Expanded(
                                                      child: FollowButton(
                                                    backgroundColor:
                                                        Colors.white,
                                                    text: 'follow',
                                                    textColor: Colors.black,
                                                    borderColor: Colors.grey,
                                                    funtion: () async {
                                                      await FireStoreMethods()
                                                          .followUser(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              userData['uid']);
                                                      setState(() {
                                                        isFollowing = true;
                                                        followers++;
                                                      });
                                                    },
                                                  )),
                                                )
                                              : Expanded(
                                                  child: FollowButton(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    text: 'follow',
                                                    textColor: Colors.white,
                                                    borderColor: Colors.blue,
                                                    funtion: () async {
                                                      await FireStoreMethods()
                                                          .followUser(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              userData['uid']);
                                                      setState(() {
                                                        isFollowing = true;
                                                        followers++;
                                                      });
                                                    },
                                                  ),
                                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        userData['username'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        userData['bio'] ?? '',
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 1.5,
                                childAspectRatio: 1),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];
                          return Container(
                              child: Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ));
                        });
                  }),
            ]),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ))
      
      ],
    );
  }
}
