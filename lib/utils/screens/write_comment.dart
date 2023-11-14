import 'package:flitter/services/comment_post_bloc/comment_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/get_comment/get_comment_bloc.dart';
import '../../services/post_get_bloc/post_get_bloc.dart';

class WriteComment extends StatefulWidget {
  const WriteComment({super.key, required this.postId});

  final int postId;

  @override
  State<WriteComment> createState() => _WriteCommentState();
}

TextEditingController textFieldController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _WriteCommentState extends State<WriteComment> {
  @override
  void initState() {
    super.initState();
    textFieldController.text = "";
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
                hintText: 'Écrivez votre commentaire ici...',
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
                        _submitComment(
                          context,
                          textFieldController.text,
                          widget.postId,
                        );
                      },
                      child: const Text('Publier'),
                    ),
                    BlocListener(
                      bloc: BlocProvider.of<CommentPostBloc>(context),
                      listener: (BuildContext context, CommentPostState state) {
                        if (state.status == CommentPostStatus.success) {
                          BlocProvider.of<GetCommentBloc>(context)
                              .add(GetComment(widget.postId));
                          BlocProvider.of<PostGetBloc>(context)
                              .add(PostGetAll(refresh: true));
                          Navigator.of(context).pop();
                          _showSuccessMessage(context);
                        }
                        if (state.status == CommentPostStatus.error) {
                          Navigator.pop(context);
                          _showErrorMessage(context, state.error.toString());
                        }
                      },
                      child: BlocBuilder<CommentPostBloc, CommentPostState>(
                        builder: (context, state) {
                          if (state.status == CommentPostStatus.loading) {
                            return const CircularProgressIndicator();
                          }
                          if (state.status == CommentPostStatus.error) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(state.error.toString(),
                                  style: const TextStyle(color: Colors.red)),
                            );
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

  void _submitComment(BuildContext context, String text, int postId) {
    final postBloc = BlocProvider.of<CommentPostBloc>(context);
    postBloc.add(CommentPostSubmitted(comment: text, postId: postId));
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Votre commentaire a été ajouté avec succès.'),
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
