import 'package:flitter/screens/connexion_screen.dart';
import 'package:flitter/screens/inscription_screen.dart';
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
        child: MaterialApp(
            home: Scaffold(
          body: InscriptionScreen(),
        )));
  }
}
