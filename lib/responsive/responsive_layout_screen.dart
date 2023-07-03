import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/poviders/user_provider.dart';
// import 'package:flutter/rendering.dart';
import 'package:social_app/utils/global_variable.dart';
class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
    final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key,required this.webScreenLayout,required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
@override
  void initState() {
   
    super.initState();
    addData();
  }
  addData() async{
    UserProvider _userProvider = Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,Constraints){
        if(Constraints.maxWidth>webScreenSize){
          // web screen 
          return widget.webScreenLayout;

        }
        return widget.mobileScreenLayout;
      },
    );
  }
}