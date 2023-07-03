import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/poviders/user_provider.dart';
import 'package:social_app/resources/firestore_method.dart';
import 'package:social_app/responsive/mobile_screen_layout.dart';
import 'package:social_app/screens/comment_screen.dart';
import 'package:social_app/screens/pofile_screen.dart';
import 'package:social_app/utils/global_variable.dart';
import 'package:social_app/utils/utils.dart';
import 'package:social_app/widgets/likes_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/models/user.dart' as model;
import 'package:social_app/poviders/user_provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  final snapshot;
  

  PostCard({
    Key? key,
    required this.snap, this.snapshot,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;
  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    //  final model.User? user = Provider.of<UserProvider>(context).getUser;
     final model.User? user = Provider.of<UserProvider>(context).getUser;
 
    return 
    Container(
        color: mobileBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [
          // HEADER SECTION
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child:  Row(children: [
              // CircleAvatar(
              //   radius: 16,
              //   backgroundImage:
              //       NetworkImage(widget.snap['profImage'].toString()),
              // ),
              // widget.snap['profImage'] != null
              //     ? CircleAvatar(
              //         radius: 16,
              //         backgroundImage:
              //             NetworkImage(widget.snap['profImage'].toString()),
              //       )
              //     : const CircleAvatar(
              //         radius: 16,
              //         backgroundImage: NetworkImage(
              //             'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHoAAAB6CAMAAABHh7fWAAAAJ1BMVEX////d3d3c3Nzx8fH8/Pzg4OD4+Pjm5ubq6uru7u7j4+P09PTZ2dmrTKdjAAAE5ElEQVRogcVb65qrIAys3BHf/3kPQduqBTNB3JM/u/utMuZCmAR4veRiXNIxBF8khKiTMx3DSFFT9JOqyORjehDfRUuwU1XoHza6R3CDbaHu8W0YjG4igLuhLzaOs7wJKO5b9zAG3M2LCHhVfb5vd+flwCu4vwcuNfUB/JbZte0GLuBW96rsbwEXcN+leOq39Q5bJTlyWO4DkyxBCGzueXkvyoqM7qZhyBl7EkyzIW7eYeMO10OBCzg4y9Jw5IwN6Z0GhfZRFgB7vLVX4W3+hLU3bEZv9xhyxr6cY2bkfP6Bnq5yy/wgcsae28jxkeD+yhKbjn4YOWM33G2eBiapu/s+M+BF+RryczP6gF2b3fYvkKfJVqJbyPLVWvW1i7DWmz9RbgQD5NomUGFrXibXu3GWoatzpAX07VpN5SR0XZ3IGqq0Uo2iQls4KZzUBpW+KqXgeuGotoE+WU2Xa65Bnbbs1YZeUjPHakGacVBb/EJLcXDR/b6B0LH2qnPAhhy+I2rAMv2bCW5gfxduYGYh1n5jA2p/5hefQ6/4xVkQevexIWBvScUGrAZvVXiKgNYtuCqbLpqLb4m5SQCitazKsOzkmkBXhM9QG1sBHxMIwvKKeVhoeQMMoHk0KJd4pZ4u6vAWJ2dzjhGG9ypsXik5ipsKS0/riw20YssH7I3ML8UncDx77wVIU4aNiC5XI852bNHRqtAY4fNUYudWV5Qhcab5ad2FzC9fGZp7phOaZYh5yf6P0Gwyewo6sNBLHzTvawD6qQjnoXt2EF4AScrQbJiBBPwoPCVGIlzMUUiABTvyoSjbutiEL/xySmEbR11JnGdIOYZY0/SsmkD1k1cuvuDqsDhQaFPZxT61yFdsoORT0GOVLtu1II1HGhSICKnaiNI0Z5E2oczbSEulZCrAOrK0AvXgSn5GCiRRIsd2MYohRR0IXrBdjDV0oaYZHOVY72zLU9DelgKx2T7BNtyanaGeD7gDjm5LvgfDNj2U5dcRtEv6mTLg3q3iUgt+pOPTLsQsTm9cNmgTviv5dR6+BdBeQZ3gYMVuFMG2XgavuVywCTAd2ccseE8pGw9nCY32wm2ffbdAuFVPZ/l8jFrrGObyp0iOBED27gr/PtAol4OvZBts9+TM7P8S+hSibCUgEGakn3LmIq0otajZBworVmLwc378Av53HWqSFaVm6clUR/ucreEqrKOegFXnqVA6eVodr8a1akRJTbr7aKLR1ZxeHe8nr9w9ilo5j9la/E4mFx1Rq8v5yFyT2h5Z7NJVWJ/FH5aVdk9ov4JhG4m87AnqVb38TSx9fYw7Y77dPQ75i83VMGvpMBL5jc329MtObF/7vS1EwAAybegoxFhk8uP1YbMvdlfT6GpICyGvu/5D7xI45oDdHjt/ZF97sipJZMa85g2c17L9Kq/G5FHKpNKozd86wuHZzXL7OXVR5aCSV82OfeBiqnvRlqZutyXiZf0shfhZ96cTzehkKjde3cTRp8tHMIEMdjdMNbF/2aUZVyrP3usmB3C7CG5KZRZMj48AJqE7RoTO6u4I9/bNoqMUXeiOmm6O6jTdcxt7k+w9dBk5F/VzxnfGbAD5F5dR53Ktb/z9uQ+69qXmXHKysdbOWfKPif4msu/bJhkDn6K357LW+piehf1KNnJaq9rkeu+H/gNsMjCN5FM0hwAAAABJRU5ErkJggg=='),
              //         backgroundColor: Colors.white,
              //       ),

             InkWell(
                // onTap: () =>
                // ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid) ,
                onTap:() => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen( uid:widget.snap['uid']
                          ), ),
                      ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.snap['profImage'] ??
                      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC'),
                  radius:
                      MediaQuery.of(context).size.width > webScreenSize ? 20 : 20,
                ),
              ),  
                
          
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ),
              
              
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: ListView(
                              padding: MediaQuery.of(context).size.width >
                                      webScreenSize
                                  ? EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width / 3)
                                  : EdgeInsets.symmetric(horizontal: 50),
                              shrinkWrap: true,
                              children: ['DELETE']
                                  .map((e) => InkWell(
                                        // onTap: () async {
                                        //   FireStoreMethods().deletePost(
                                        //       widget.snap['postId']);
                                        //   Navigator.of(context).pop();
                                        // },
                                  // onTap:(){
                                  //         if(widget.snap['uid']!= FirebaseAuth.instance.currentUser!.uid){
                                  //           print('You are not allowed to delete');
                                  //       }else{
                                  //           FireStoreMethods().deletePost(
                                  //             widget.snap['postId']);
                                  //         Navigator.of(context).pop();
                                        
                                  // }
                                  // },
                                  
                                        child: Container(
                                          padding: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  webScreenSize
                                              ? EdgeInsets.symmetric(
                                                  vertical:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          100,
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          100,
                                                )
                                              : const EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 16),
                                              
                                          child: Text(e),
                                 
                                        ),
                                                               onTap:(){
                                          if(widget.snap['uid']!= FirebaseAuth.instance.currentUser!.uid){
                                            print('You are not allowed to delete');
                                        }else{
                                            FireStoreMethods().deletePost(
                                              widget.snap['postId']);
                                          Navigator.of(context).pop();
                                        
                                  }
                                  },
                                 
                                      ))
                                  .toList(),
                            ),
                          ));
                },
                icon: Icon(Icons.more_vert),
              )
            ]),

            // IMAGE  SELECTION
          ),

          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(
                widget.snap['postId'].toString(),
                user?.uid ?? '',
                widget.snap['likes'] ?? 0,
              );
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  setState(() {
                    isLikeAnimating = true;
                  });
                },
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height + 0.35,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['postUrl'],
                      fit: BoxFit.cover,
                    )),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          if (mounted) {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          }
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 120,
                      )),
                ),
              ],
            ),
          ),

          Row(children: [
            LikeAnimation(
              isAnimating: widget.snap['likes'] != null&&
                  widget.snap['likes'].contains(user?.uid ?? ''),
              child: IconButton(
                  onPressed: () async {
                    await FireStoreMethods().likePost(
                      widget.snap['postId'].toString(),
                      user?.uid ?? '',
                      widget.snap['likes'] ?? [],
                    );
                  },
                  icon: widget.snap['likes'] != null &&
                          widget.snap['likes'].contains(user?.uid ?? '')
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )),
            ),
            IconButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(snap: widget.snap),
                      ),
                    ),
                icon: const Icon(Icons.comment_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.bookmark_border,
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ]),

          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.w800),
                      child: Text(
                        widget.snap['likes']?.length!=null?
                        '${widget.snap['likes']?.length}  likes  ':'0 like',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: widget.snap['username'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "  ${widget.snap['description']}",
                            )
                          ]),
                    ),
                  ),
                  InkWell(
               onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>CommentsScreen(snap: widget.snap),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'View all $commentLen comments',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(207, 241, 223, 223),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(207, 241, 223, 223),
                      ),
                    ),
                  ),
                ]),
          ),
        ]));
  }
}


