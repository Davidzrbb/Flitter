import 'package:flitter/models/get_post.dart';
import 'package:flitter/utils/shimmer_image_url.dart';
import 'package:flitter/utils/voir_plus_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      leading: RandomAvatar(
        item.author.id.toString(),
        height: 50,
        width: 52,
      ),
      title: Text(item.author.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoirPlusString(content: item.content),
            if (item.image != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ShimmerImageUrl(
                    url: item.image!.url, width: 200, height: 200),
              )
          ],
        ),
      ),
      trailing: Text(
        DateFormat('dd/MM à HH:mm', 'fr_FR').format(
          DateTime.fromMillisecondsSinceEpoch(item.createdAt),
        ),
      ),
    );
  }
}
