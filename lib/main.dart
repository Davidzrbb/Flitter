import 'package:flitter/router/go_router.dart';
import 'package:flitter/services/connexion_bloc/connexion_bloc.dart';
import 'package:flitter/services/inscription_bloc/inscription_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ConnexionBloc>(
            create: (context) => ConnexionBloc(),
          ),
          BlocProvider<InscriptionBloc>(
            create: (context) => InscriptionBloc(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flitter',
          routerConfig: router,
        ));
  }
}
