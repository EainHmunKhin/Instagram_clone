import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/screens/add_post_screen.dart';
import 'package:social_app/screens/feed_screen.dart';
import 'package:social_app/screens/pofile_screen.dart';

import '../screens/search_screen.dart';

const webScreenSize = 800;


 List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('notif'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
