import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';

class BottomBar extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.only(bottom:16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 50,
            ),
            ImageIcon(
              AssetImage('assets/images/home.png'),
              // size: 150,
            ),
            SizedBox(
              width: 50,
            ),
            ImageIcon(
              AssetImage('assets/images/trophy.png'),
              // size: 150,
            ),
            SizedBox(
              width: 50,
            ),
            ImageIcon(
              AssetImage('assets/images/upload.png'),
              // size: 150,
            ),
            SizedBox(
              width: 50,
            ),
            ImageIcon(
              AssetImage('assets/images/wallet.png'),
              // size: 150,
            ),
            SizedBox(
              width: 50,
            ),
            ImageIcon(
              AssetImage('assets/images/menu.png'),
              // size: 150,
            ),
            SizedBox(
              width: 50,
            ),
          ],
        ),
      ),
    );
  }

  menuButton(String icon) {
    return Column(
      children: [
        Image.asset(icon),
      ],
    );
  }
}
