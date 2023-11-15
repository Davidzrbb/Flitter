import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../services/connexion_bloc/connexion_bloc.dart';

class CheckUserIsLogIn extends StatefulWidget {
  const CheckUserIsLogIn({super.key, required this.child});

  final Widget child;

  @override
  State<CheckUserIsLogIn> createState() => _CheckUserIsLogInState();
}

class _CheckUserIsLogInState extends State<CheckUserIsLogIn> {
  @override
  void initState() {
    final connexionBloc = BlocProvider.of<ConnexionBloc>(context);
    connexionBloc.add(IsConnected(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnexionBloc, ConnexionState>(
      listener: (context, state) {
        if (state.status == ConnexionStatus.error) {
          context.go('/sign_in');
        }
      },
      child: widget.child,
    );
  }
}
