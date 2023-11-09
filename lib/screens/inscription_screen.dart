import 'package:flitter/models/inscription_user.dart';
import 'package:flitter/services/inscription_bloc/inscription_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InscriptionScreen extends StatelessWidget {
  InscriptionScreen({Key? key}) : super(key: key);

  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _nameTextController = TextEditingController();
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
              Text('Inscription',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: _nameTextController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
              ),
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
                onPressed: () => _signUp(context),
                child: const Text('Sign up'),
              ),
              BlocBuilder<InscriptionBloc, InscriptionState>(
                builder: (context, state) {
                  // Handle different states here
                  if (state.status == InscriptionStatus.loading) {
                    return const CircularProgressIndicator();
                  } else if (state.status == InscriptionStatus.success) {
                    return const Text('Sign up successful',
                        style: TextStyle(color: Colors.green));
                  } else if (state.status == InscriptionStatus.error) {
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
                child: const Text('You have an account? Sign In.'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailTextController.text;
      final String password = _passwordTextController.text;
      final String name = _nameTextController.text;
      final inscriptionBloc = BlocProvider.of<InscriptionBloc>(context);
      inscriptionBloc.add(InscriptionSubmitted(InscriptionUser(
          email: email, password: password, name: name
      )));
    }
  }
}
