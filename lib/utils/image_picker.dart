import 'dart:convert';
import 'dart:io';

import 'package:flitter/utils/shimmer_image_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../services/post_bloc/post_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            await pickImages();
          },
          label: const Text('Images'),
          icon: const Icon(Icons.image),
        ),
        BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state.imageBase64 != null) {
              return Column(
                children: [
                  // This will show the image on the screen
                  SizedBox(
                    width: 150,
                    child: !state.imageBase64!.path.contains('https://xoc1-kd2t-7p9b.n7c.xano.io')
                        ? Image.file(File(state.imageBase64!.path))
                        : ShimmerImageUrl(
                            url: state.imageBase64!.path,
                            width: 150,
                            height: 150),
                  ),
                  // This will remove the image from the UI
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        BlocProvider.of<PostBloc>(context)
                            .add(PostImagePicked(null));
                      });
                    },
                    label: const Text('Remove Image'),
                    icon: const Icon(Icons.close),
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  Future pickImages() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      BlocProvider.of<PostBloc>(context).add(PostImagePicked(imageTemp));
    });
  }
}
