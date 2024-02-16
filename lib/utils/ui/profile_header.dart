import 'package:flitter/models/get_profile.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'dart:math' as math;

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile, required this.postNumber});

  final GetProfile profile;
  final int postNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0)),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.blue),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, left: 10),
                      child: Text(
                        profile.name,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, right: 10),
                      child: Text(
                        "${postNumber.toString()} Posts",
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Positioned(
        child: Container(
          alignment: AlignmentDirectional.center,
          child: RandomAvatar(
            profile.id.toString(),
            height: 100,
            width: 100,
          ),
        ),
      ),
    ]);
  }
}
