import 'package:flutter/material.dart';

class UserActivity extends StatelessWidget {
  const UserActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20.0,
      bottom: 50,
      child: Column(
        children: [
          ImageIcon(
          
            AssetImage('assets/images/like.png'),
          ),
          SizedBox(height: 20),
          ImageIcon(
            AssetImage('assets/images/share.png'),
          ),
          SizedBox(height: 20),
          ImageIcon(
            AssetImage('assets/images/hot_emoji.png'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
