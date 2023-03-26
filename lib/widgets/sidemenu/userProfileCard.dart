import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../views/accountSettingsPage.dart';

class UserProfileCard extends StatelessWidget {
  final User user;

  UserProfileCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AccountSettingsPage(user: user);
                      },
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image:
                            Image.memory(base64Decode(user.profileImageBase64))
                                .image,
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(
                        width: 3,
                        color: Color.fromRGBO(85, 85, 85, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      user.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
