import 'package:flitter/connexion_bloc/connexion_bloc.dart';
import 'package:flitter/connexion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ConnexionBloc(),
        child: const MaterialApp(
            home: Scaffold(
          body: ConnexionScreen(),
        )));
  }
}
