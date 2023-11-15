import 'package:flitter/utils/screens/post_list.dart';
import 'package:flitter/utils/screens/write_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../services/connexion_bloc/connexion_bloc.dart';

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
                return const WritePostScreen();
              },
            );
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
