import 'package:flitter/utils/ui/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../models/write_post.dart';
import '../services/connexion/connexion_bloc.dart';
import '../services/post_create/post_bloc.dart';
import '../utils/ui/floating_action_button_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Flitter'),
        centerTitle: true,
        actions: [
          BlocBuilder<ConnexionBloc, ConnexionState>(
            builder: (context, state) {
              if (state.user != null) {
                return IconButton(
                  icon: const Icon(Icons.power_off_outlined),
                  onPressed: (() => _signOut(context)),
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.power),
                  onPressed: (() => context.go('/sign_in')),
                );
              }
            },
          ),
        ],
      ),
      body: const PostListScreen(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: FloatingActionButton(
          heroTag: 'addPost',
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      return FloatingActionButtonScreen(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<PostBloc>(context).add(
                              PostSubmitted(
                                WritePost(
                                  content: textFieldController.text,
                                  imageBase64: state.imageBase64,
                                ),
                              ),
                            );
                          }
                        },
                        url: null,
                        content: null,
                        imagePicker: true,
                      );
                    },
                  );
                });
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _signOut(BuildContext context) {
    final connexionBloc = BlocProvider.of<ConnexionBloc>(context);
    connexionBloc.add(Disconnected());
  }
}
