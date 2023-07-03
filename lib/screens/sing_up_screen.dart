import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/resources/auth_method.dart';
import 'package:social_app/responsive/mobile_screen_layout.dart';
import 'package:social_app/responsive/responsive_layout_screen.dart';
import 'package:social_app/responsive/web_screen_layout.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/utils/global_variable.dart';

// import 'social_app/utils/global_variable.dart';
import 'package:social_app/utils/utils.dart';
import 'package:social_app/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(res, context);
    }
  }

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    if (im != null) {
      setState(() {
        _image = im;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            // padding: MediaQuery.of(context).size.width > webScreenSize
            //     ? EdgeInsets.symmetric(
            //         horizontal: MediaQuery.of(context).size.width / 3)
            //     : EdgeInsets.symmetric(horizontal: 32),
            // width: double.infinity,
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3,
                  )
                : const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
            width: double.infinity,
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                    SvgPicture.asset(
                      'assets/ic_instagram.svg',
                      colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 231, 220, 220), BlendMode.srcIn),
                      height: 64,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC'),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your username',
                      textInputType: TextInputType.text,
                      textEditingController: _usernameController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your bio',
                      textInputType: TextInputType.text,
                      textEditingController: _bioController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: signUpUser,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: Colors.blue,
                        ),
                        child: !_isLoading
                            ? const Text(
                                'Sign up',
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            'Already have an account?',
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                          child: Container(
                            child: const Text(
                              ' Login.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
