import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/comment.dart';

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

                      /*                     BlocListener(
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
                  )*/
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _patchPost(BuildContext context, String text, id) {
    if (_formKey.currentState!.validate()) {
/*      BlocProvider.of<CommentPatchBloc>(context).add(
        CommentPatchEvent.patchComment(
          text,
          id,
        ),
      );*/
    }
  }
}
