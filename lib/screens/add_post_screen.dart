// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors.dart';

import 'package:social_app/poviders/user_provider.dart';
import 'package:social_app/resources/firestore_method.dart';
import 'package:social_app/utils/utils.dart';

import '../models/user.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptingController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
          _descriptingController.text, _file!, uid, username, profImage);
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        clearImage();
        showSnackBar('Posted!', context);
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Create a Post'),
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Take a photo'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List? file = await pickImage(ImageSource.camera);

                    if (file != null) {
                      setState(() {
                        _file = file;
                      });
                    }
                  },
                ),
                SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Choose from gallery'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Uint8List? file = await pickImage(ImageSource.gallery);

                      if (file != null) {
                        setState(() {
                          _file = file;
                        });
                      }
                    }),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Cancel'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    bool isLoading = false;

    // final UserProvider userProvider = Provider.of<UserProvider>(context);
    if (_file == null) {
      return Container(
        child: IconButton(
          icon: const Icon(Icons.upload),
          onPressed: () => _selectImage(context),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: clearImage,
            ),
            title: const Text('Post to'),
            centerTitle: false,
            actions: [
              TextButton(
                  onPressed: () =>
                      postImage(user!.uid, user.username, user.photoUrl),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ))
            ],
          ),
          body: Column(children: [
            _isLoading
                ? LinearProgressIndicator()
                : Padding(
                    padding: EdgeInsets.only(top: 0),
                  ),
            const Divider(),
            Flexible(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // child: _file != null
                      //     ? 
                        child:Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  user?.photoUrl ?? 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC',
                                ),
                              ),
                            )
                          // : Align(
                          //     alignment: Alignment.topCenter,
                          //     child: const CircleAvatar(
                          //       backgroundImage: NetworkImage(
                          //         '// navigate to the home screen
      
                          //       ),
                          //     ),
                          //   ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width + 0.3,
                        child: TextField(
                          controller: _descriptingController,
                          decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                            image: MemoryImage(_file!),
                            alignment: FractionalOffset.topCenter,
                          ))),
                        ),
                      ),
                    ),
                  ]),
            ),
          ]));
    }
  }
}
