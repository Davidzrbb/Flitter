import 'package:flitter/models/get_post.dart';
import 'package:flitter/utils/date_formater_get_timestamp.dart';
import 'package:flitter/utils/shimmer_image_url.dart';
import 'package:flitter/utils/voir_plus_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_avatar/random_avatar.dart';

class TilePost extends StatelessWidget {
  const TilePost({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
          child: RandomAvatar(
            item.author.id.toString(),
            height: 50,
            width: 52,
          ),
          onTap: () {
            context.pushNamed('display_profile', pathParameters: {
              'userId': item.author.id.toString(),
            });
          }),
      title: Text(item.author.name,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoirPlusString(content: item.content),
            if (item.image != null)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ShimmerImageUrl(
                    url: item.image!.url, width: 200, height: 200),
              )
          ],
        ),
      ),
      trailing: DateFormatGetTimestamp(timestamp: item.createdAt, fontSize: 12),
    );
  }
}
