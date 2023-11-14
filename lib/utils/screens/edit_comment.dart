import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/comment.dart';
import '../../models/patch_comment.dart';
import '../../services/comment_patch_bloc/comment_patch_bloc.dart';

import '../../services/get_comment/get_comment_bloc.dart';

class EditComment extends StatefulWidget {
  const EditComment({super.key, required this.comment});

  final Comment comment;

  @override
  State<EditComment> createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  TextEditingController textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    textFieldController.text = widget.comment.content;
    super.initState();
  }

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
                  return 'Veuillez écrire votre commentaire';
                }
                return null;
              },
              controller: textFieldController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Modifier votre commentaire...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 16.0),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _patchPost(
                          context,
                          textFieldController.text,
                          widget.comment.id,
                        );
                      },
                      child: const Text('Publier'),
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
                          _showErrorMessage(context, state.error.toString());
                        }
                      },
                      child: BlocBuilder<CommentPatchBloc, CommentPatchState>(
                        builder: (context, state) {
                          if (state.status == CommentPatchStatus.loading) {
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

  void _patchPost(BuildContext context, String text, id) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<CommentPatchBloc>(context).add(
        CommentPatch(
          CommentPatchModel(
            id: id,
            comment: text,
          ),
        ),
      );
    }
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Votre commentaire a été modifié avec succès.'),
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
