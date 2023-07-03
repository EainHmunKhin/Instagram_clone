import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_app/poviders/user_provider.dart';
import 'package:social_app/utils/global_variable.dart';

import '../models/user.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(children: [
        //    backgroundImage:NetworkImage(
        // //  widget.snap['profilePic']??'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC'),
        //  widget.snap['profilePic']!= null? widget.snap['profilePic']!:'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC',
        // //

        //    )
        //  widget.snap['profilePic']!= null
        //                   ? CircleAvatar(
        //                       radius: 14,
        //                       backgroundImage:NetworkImage( widget.snap['profilePic']!),
        //                     )
        //                   : const CircleAvatar(
        //                       radius: 14,
        //                       backgroundImage: NetworkImage(
        //                           'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC'),
        //                   ),

        widget.snap['profilePic'] != null
            ? 
               CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.snap['profilePic'],
                  ),
                )
              
            : CircleAvatar(
                backgroundImage: NetworkImage(
                   'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAH8AAAB/CAMAAADxY+0hAAAAJFBMVEX////d3d3a2tr5+fny8vLg4ODk5OTu7u7r6+vo6Oj19fX8/PzytUwjAAAE7ElEQVRogcVb6ZqrIAyt7Mv7v+8AaqtV4SRA5/yYb+4dNSF7ArxeLMigrPMJJv9wVgXJ+xAZUSqvl2URYvmg/EN7K+Nc4tIavRwJnyEWbew0QUinxTPtjyi0m8BCtLpN+82DtmMVIT1OfGPBjxNCMETiK0wYQl0a6trfMjD9MohkyZ848J12YHuoFw5sB3VJsPlHBjRbCa6b+ArHoh4HLH6F0AwrUKOoFw4UlbwdSD2DaIZdXncH4Snk2SGnwoAhkB9OPQNlIOop5FOBgrnBLPKJgf8T/gpABTPJAwwMd7wzWm7Yne+aDFQDUZhMPaNWFc1efcEz+bm2t+PRBqcrf8WTCcifUM+4r4h+I/2MWw0MLTjquC1HGORFAYeBK3lH+k7udH3q+kNQyvlaT3z/+qUkjaQv6K9OXypPZOA7FRPev28toyLVy195QOLvPlfzgdKin9eALl+Yag2jYPpnAcChp1XHR7xyPQoAjLxIK4f60SkKY69A5Rsexw6vQM+j9XMAGfjoEor8eP8AWuHngwjDlB4WM6d3EEb4FaQpAlbF7goAxE9toKEeZlNAxB+FgcXTVaWIvZJnOEhAFQF8lNa8F0D5dP0soCvG/AaJgyWgAbGfvnwwpWS1ttVP870diFdlA2gHC6rxrwDyQMlBbfNjzg/b6y+KbZofT/yQArIBNh+6KZYhIONbxE6xtH8FFtfaLT/H+zKQECTbyY89wUcMULXdhD473tEOrOnbbfdn0287QJLtf9Nv54mZ9B3gpRP1vwD0p9o/sv6Z/u8A/fPSH1QDJv237Z8b/4EtpKTbdpq+zCpAACWoAOIf1wGQbZREHxg58wwQagECUifyFADt3krES1kRAPH+UtgDT3EqEGwM8YKiJCcFI9TLwpBOjS4AbAbhQUFd56UNYNovcoUaJWoNDm6j5a9i2620JADOwNaZDjR9IrXgmPT3RYHTIjwIoOS3T6KzZ9QJ4f3zzajg5zEG8BHwPtKDh9+ICginB3aTQgemrel7BmEXS7x3YuFXWjqIpG2Y92uEg07VM22UM4rHsQZh9yXh6WQhbQPoFFJpRz6EURc7CJ66B3fMaeS9T6GdkrFwEWWwjFMT55zOOPMiFr1orddf6Tin9B9tvX/wFUvQkD0OXxb0YwFcQ2l7DAjvdANPXgu6hgtob4NEkRyivpy7gvb5jeTv9BGoVJU8eFfPPtSBQvNP0Nonz7xdzt0kQGj29KXgNiY/VdM3GnC959jjTW572kq8pqERJ8gvDfZzLX8OApQTm1WcDbFWRR1LcXLP84yTZVVXpSE2yTgItt5Khinkjww0TGqrRQcKf8WmAtG06BKHGRueLZQSBRkkZFGNsvwjDKrUJKrxy89FNqpUJ6bIH7cpK4bFnh1GUDwqGSH/2sYNpCbOsELKnH2Z7wiVvkZMJZnjUTHAsaSZNDZEB1IzrSkZwQARpMVzdxBlFkF3/dNzC8z2XSIrV9e6Eln+AvcqX7402H8FLh+qFIyrfCFzrkcUcFmHi762/BVEpZdu2zlwYPINWw/ero3S58fNuPi1SVNo35Zn8FlcHI3VsV6ATd7kHjURlTO59Rx+/XX/vjOlt02yLTeu1/nLK0aZT2Gnv5W/mu6epcZCvnx9OHa+DWD2/9KeZKY85PZ6axQO599NbtCn0/4gyiz1giD5987/AEyfMESKduPLAAAAAElFTkSuQmCC',
                ),
              ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: widget.snap['name'],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                        text: ' ${widget.snap['text']}',
                        style: TextStyle(
                          color: Colors.white,
                        ))
                  ])),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w200),
                    ),
                  )
                ]),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.favorite,
            size: 16,
          ),
        )
      ]),
    );
  }
}
