import 'package:flitter/screens/post_list_screen.dart';
import 'package:flitter/screens/write_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../services/connexion_bloc/connexion_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flitter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (() => _signOut(context)),
          ),
        ],
      ),
      body: const PostListScreen(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: FloatingActionButton(
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
    context.go('/');
  }
}
