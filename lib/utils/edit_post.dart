import 'package:flitter/models/get_post.dart';
import 'package:flitter/services/post_patch_bloc/post_patch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../models/write_post.dart';
import '../services/post_bloc/post_bloc.dart';
import 'image_picker.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  _EditPostScreen createState() => _EditPostScreen();
}

class _EditPostScreen extends State<EditPostScreen> {
  @override
  void initState() {
    textFieldController.text = widget.item.content;
    if (widget.item.image?.url != null) {
      final File file = File(widget.item.image!.url);
      BlocProvider.of<PostBloc>(context).add(PostImagePicked(file));
    } else {
      BlocProvider.of<PostBloc>(context).add(PostImagePicked(null));
    }
    super.initState();
  }

  TextEditingController textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.70,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Fermer',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez écrire votre post';
                }
                return null;
              },
              controller: textFieldController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Écrivez votre post ici...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const ImagePickerScreen(),
                const SizedBox(width: 16.0),
                Column(
                  children: [
                    BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            _patchPost(
                              context,
                              textFieldController.text,
                              state.imageBase64 != null
                                  ? state.imageBase64!.path.contains(
                                          'https://xoc1-kd2t-7p9b.n7c.xano.io')
                                      ? null
                                      : state.imageBase64
                                  : null,
                              widget.item.id,
                            );
                          },
                          child: const Text('Publier'),
                        );
                      },
                    ),
                    BlocListener(
                      bloc: BlocProvider.of<PostPatchBloc>(context),
                      listener: (BuildContext context, PostPatchState state) {
                        if (state.status == PostPatchStatus.success) {
                          Navigator.pop(context);
                          _showSuccessMessage(context);
                        }
                        if (state.status == PostPatchStatus.error) {
                          Navigator.pop(context);
                          _showErrorMessage(context, state.error.toString());
                        }
                      },
                      child: BlocBuilder<PostPatchBloc, PostPatchState>(
                        builder: (context, state) {
                          if (state.status == PostPatchStatus.loading) {
                            return const CircularProgressIndicator();
                          }
                          return const SizedBox();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _patchPost(BuildContext context, String? content, File? image, int id) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<PostPatchBloc>(context).add(
        PostPatch(
            WritePost(
              content: textFieldController.text,
              imageBase64: image,
            ),
            id),
      );
    }
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Votre post a été publié avec succès.'),
        backgroundColor: Colors.green,
        duration: Duration(
            seconds: 3), // Durée pendant laquelle le message sera affiché
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String? content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content ?? "erreur"),
        backgroundColor: Colors.red,
        duration: const Duration(
            seconds: 3), // Durée pendant laquelle le message sera affiché
      ),
    );
  }
}
