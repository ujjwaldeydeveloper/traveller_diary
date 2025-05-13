import 'package:flutter/material.dart';
import '../utills/constants.dart';
// import 'package:hot_or_not/utills/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 70,
      left: 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  child: Image.asset('assets/images/profile.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(userName,
                          style: TextStyle(
                              fontSize: 16.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/view.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            userFollower,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                userDescription,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
