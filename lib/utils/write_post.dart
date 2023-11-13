import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../models/write_post.dart';
import '../services/post_bloc/post_bloc.dart';
import 'image_picker.dart';

class WritePostScreen extends StatefulWidget {
  const WritePostScreen({super.key});

  @override
  _WritePostScreenState createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
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
                            _submitPost(
                              context,
                              textFieldController.text,
                              state.imageBase64,
                            );
                          },
                          child: const Text('Publier'),
                        );
                      },
                    ),
                    BlocListener(
                      bloc: BlocProvider.of<PostBloc>(context),
                      listener: (BuildContext context, PostState state) {
                        if (state.status == PostStatus.success) {
                          Navigator.pop(context);
                          showSuccessMessage(context);
                        }
                      },
                      child: BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          if (state.status == PostStatus.loading &&
                              state.imageBase64 == null &&
                              textFieldController.text.isNotEmpty) {
                            return const CircularProgressIndicator();
                          }
                          if (state.status == PostStatus.error) {
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

  void _submitPost(BuildContext context, String? content, File? image) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<PostBloc>(context).add(
        PostSubmitted(
          WritePost(
            content: textFieldController.text,
            imageBase64: image,
          ),
        ),
      );
    }
  }

  void showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Votre post a été publié avec succès.'),
        backgroundColor: Colors.green,
        duration: Duration(
            seconds: 3), // Durée pendant laquelle le message sera affiché
      ),
    );
  }
}
