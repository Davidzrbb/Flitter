import 'package:flutter/material.dart';
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
        /*add icon*/
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (() => _signOut(context)),
          ),
        ],
      ),
      body:
          BlocBuilder<ConnexionBloc, ConnexionState>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Welcome !'),
              const SizedBox(height: 20),
              Text('${state.user?.email}'),
              Text('${state.user?.name}'),
            ],
          ),
        );
      }),
    );
  }

  void _signOut(BuildContext context) {
    final connexionBloc = BlocProvider.of<ConnexionBloc>(context);
    connexionBloc.add(Disconnected());
    context.go('/');
  }
}
