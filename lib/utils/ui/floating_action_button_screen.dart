import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/comment_patch/comment_patch_bloc.dart';
import '../../services/comment_post/comment_post_bloc.dart';
import '../../services/comment_get/get_comment_bloc.dart';
import '../../services/post_create/post_bloc.dart';
import '../../services/post_get/post_get_bloc.dart';
import '../../services/post_patch/post_patch_bloc.dart';
import '../image_picker.dart';

class FloatingActionButtonScreen extends StatefulWidget {
  const FloatingActionButtonScreen({
    super.key,
    required this.onPressed,
    required this.url,
    required this.content,
    this.postId,
    this.imagePicker,
  });

  final VoidCallback onPressed;
  final String? url;
  final String? content;
  final int? postId;
  final bool? imagePicker;

  @override
  State<FloatingActionButtonScreen> createState() =>
      _FloatingActionButtonScreenState();
}

TextEditingController textFieldController = TextEditingController();
final formKey = GlobalKey<FormState>();

class _FloatingActionButtonScreenState
    extends State<FloatingActionButtonScreen> {
  @override
  void initState() {
    if (widget.content != null) {
      textFieldController.text = widget.content!;
    } else {
      textFieldController.text = "";
    }
    if (widget.url != null) {
      final File file = File(widget.url!);
      BlocProvider.of<PostBloc>(context).add(PostImagePicked(file));
    } else {
      BlocProvider.of<PostBloc>(context).add(PostImagePicked(null));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                  return 'Erreur : le champ est vide !';
                }
                return null;
              },
              controller: textFieldController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Quoi de neuf ?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.imagePicker == true
                    ? const ImagePickerScreen()
                    : const SizedBox(),
                const SizedBox(width: 16.0),
                Column(
                  children: [
                    MultiBlocListener(
                      listeners: [
                        BlocListener(
                          bloc: BlocProvider.of<PostBloc>(context),
                          listener: (BuildContext context, PostState state) {
                            if (state.status == PostStatus.success) {
                              final productsBloc =
                                  BlocProvider.of<PostGetBloc>(context);
                              productsBloc.add(PostGetAll(refresh: true));
                              Navigator.pop(context);
                              _showSuccessMessage(context);
                            }
                            if (state.status == PostStatus.error) {
                              Navigator.pop(context);
                              _showErrorMessage(
                                  context, state.error.toString());
                            }
                          },
                        ),
                        BlocListener(
                          bloc: BlocProvider.of<CommentPostBloc>(context),
                          listener:
                              (BuildContext context, CommentPostState state) {
                            if (state.status == CommentPostStatus.success) {
                              if (state.postId != null) {
                                BlocProvider.of<GetCommentBloc>(context)
                                    .add(GetComment(state.postId!));
                              }
                              BlocProvider.of<PostGetBloc>(context)
                                  .add(PostGetAll(refresh: true));
                              Navigator.of(context).pop();
                              _showSuccessMessage(context);
                            }
                            if (state.status == CommentPostStatus.error) {
                              Navigator.pop(context);
                              _showErrorMessage(
                                  context, state.error.toString());
                            }
                          },
                        ),
                        BlocListener(
                          bloc: BlocProvider.of<PostPatchBloc>(context),
                          listener:
                              (BuildContext context, PostPatchState state) {
                            if (state.status == PostPatchStatus.success) {
                              final productsBloc =
                                  BlocProvider.of<PostGetBloc>(context);
                              productsBloc.add(PostGetAll(refresh: true));
                              Navigator.pop(context);
                              _showSuccessMessage(context);
                            }
                            if (state.status == PostPatchStatus.error) {
                              Navigator.pop(context);
                              _showErrorMessage(
                                  context, state.error.toString());
                            }
                          },
                        ),
                        BlocListener(
                          bloc: BlocProvider.of<CommentPatchBloc>(context),
                          listener:
                              (BuildContext context, CommentPatchState state) {
                            if (state.status == CommentPatchStatus.success) {
                              if (state.postId != null) {
                                BlocProvider.of<GetCommentBloc>(context)
                                    .add(GetComment(state.postId!));
                              }
                              Navigator.pop(context);
                              _showSuccessMessage(context);
                            }
                            if (state.status == CommentPatchStatus.error) {
                              Navigator.pop(context);
                              _showErrorMessage(
                                  context, state.error.toString());
                            }
                          },
                        ),
                      ],
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              widget.onPressed();
                            },
                            child: const Text('Publier'),
                          ),
                        ],
                      ),
                    ),
                    buildLoadingIndicator(BlocProvider.of<PostBloc>(context)),
                    buildLoadingIndicator(
                        BlocProvider.of<PostGetBloc>(context)),
                    buildLoadingIndicator(
                        BlocProvider.of<CommentPostBloc>(context)),
                    buildLoadingIndicator(
                        BlocProvider.of<CommentPatchBloc>(context)),
                    buildLoadingIndicator(
                        BlocProvider.of<PostPatchBloc>(context)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mise à jour réussie !'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget buildLoadingIndicator(BlocBase bloc) {
    return BlocBuilder<BlocBase, dynamic>(
      bloc: bloc,
      builder: (context, state) {
        if ((state.statusProfileInfo == PostStatus.loading &&
            state.imageBase64 == null &&
            textFieldController.text.isNotEmpty)) {
          print("toto");
        }
        if (state.statusProfileInfo == PostPatchStatus.loading ||
            state.statusProfileInfo == CommentPostStatus.loading ||
            state.statusProfileInfo == CommentPatchStatus.loading ||
            state.statusProfileInfo == PostStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _showErrorMessage(BuildContext context, String? content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content ?? "erreur"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
