import 'package:flitter/models/get_post.dart';
import 'package:flitter/models/get_profile.dart';
import 'package:flitter/utils/date_formater_get_timestamp.dart';
import 'package:flitter/utils/shimmer_image_url.dart';
import 'package:flitter/utils/voir_plus_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, left: 10),
                      child: Text(
                        this.profile.name,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60, right: 10),
                      child: Text(
                        "${this.postNumber.toString()} Posts",
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
              width: double.infinity,
            ),
          ),
        ],
      ),
      Positioned(
        child: Container(
          alignment: AlignmentDirectional.center,
          child: RandomAvatar(
            this.profile.id.toString(),
            height: 100,
            width: 100,
          ),
        ),
      ),
    ]);
  }
}
