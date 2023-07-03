import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/utils/global_variable.dart';

import '../colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTape(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
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
            onPressed: () => navigationTape(0),
            icon: Icon(Icons.home),
            color: _page == 0 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () => navigationTape(1),
            icon: Icon(Icons.search),
            color: _page == 1 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () => navigationTape(2),
            icon: Icon(Icons.add_a_photo),
            color: _page == 2 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () => navigationTape(3),
            icon: Icon(Icons.favorite),
            color: _page == 3 ? Colors.white : Colors.grey,
          ),
          IconButton(
            onPressed: () => navigationTape(4),
            icon: Icon(Icons.person),
            color: _page == 4 ? Colors.white : Colors.grey,
          ),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
        
      ),
    );
  }
}
