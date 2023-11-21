import 'package:flitter/router/go_router.dart';
import 'package:flitter/services/comment_delete/comment_delete_bloc.dart';
import 'package:flitter/services/comment_patch/comment_patch_bloc.dart';
import 'package:flitter/services/comment_post/comment_post_bloc.dart';
import 'package:flitter/services/connexion/connexion_bloc.dart';
import 'package:flitter/services/comment_get/get_comment_bloc.dart';
import 'package:flitter/services/inscription/inscription_bloc.dart';
import 'package:flitter/services/post_create/post_bloc.dart';
import 'package:flitter/services/post_delete/post_delete_bloc.dart';
import 'package:flitter/services/post_get/post_get_bloc.dart';
import 'package:flitter/services/post_patch/post_patch_bloc.dart';
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
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(),
          ),
          BlocProvider<PostGetBloc>(
            create: (context) => PostGetBloc(),
          ),
          BlocProvider<PostDeleteBloc>(
            create: (context) => PostDeleteBloc(),
          ),
          BlocProvider<PostPatchBloc>(
            create: (context) => PostPatchBloc(),
          ),
          BlocProvider<GetCommentBloc>(
            create: (context) => GetCommentBloc(),
          ),
          BlocProvider<CommentPatchBloc>(
            create: (context) => CommentPatchBloc(),
          ),
          BlocProvider<CommentDeleteBloc>(
            create: (context) => CommentDeleteBloc(),
          ),
          BlocProvider<CommentPostBloc>(
            create: (context) => CommentPostBloc(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flitter',
          routerConfig: router,
        ));
  }
}
