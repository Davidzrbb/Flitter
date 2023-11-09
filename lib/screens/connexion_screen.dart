import 'package:flitter/models/ConnexionUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/connexion_bloc/connexion_bloc.dart';

class ConnexionScreen extends StatelessWidget {
  ConnexionScreen({Key? key}) : super(key: key);

  final _passwordTextController = TextEditingController();

  final _emailTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 370,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sign in',
                  style: Theme.of(context).textTheme.headlineMedium),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: _emailTextController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  controller: _passwordTextController,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
              ),
              ElevatedButton(
                onPressed: () => _signIn(context),
                child: const Text('Sign in'),
              ),
              BlocBuilder<ConnexionBloc, ConnexionState>(
                builder: (context, state) {
                  // Handle different states here
                  if (state.status == ConnexionStatus.loading) {
                    return const CircularProgressIndicator();
                  } else if (state.status == ConnexionStatus.success) {
                    return const Text('Login successful',
                        style: TextStyle(color: Colors.green));
                  } else if (state.status == ConnexionStatus.error) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(state.error.toString(),
                          style: const TextStyle(color: Colors.red)),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              TextButton(
                onPressed: () => {},
                child: const Text('Don\'t have an account? Sign up.'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailTextController.text;
      final String password = _passwordTextController.text;
      final connexionBloc = BlocProvider.of<ConnexionBloc>(context);
      connexionBloc.add(
          ConnexionSubmitted(ConnexionUser(email: email, password: password)));
    }
  }
}
