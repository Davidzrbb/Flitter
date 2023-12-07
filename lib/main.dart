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
import 'package:flitter/services/repository/comments/api_comment_data_source.dart';
import 'package:flitter/services/repository/comments/comments_repository.dart';
import 'package:flitter/services/repository/posts/api_post_data_source.dart';
import 'package:flitter/services/repository/posts/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostsRepository>(
          create: (context) => PostsRepository(
            productsDataSource: ApiPostDataSource(),
          ),
        ),
        RepositoryProvider<CommentsRepository>(
          create: (context) => CommentsRepository(
            commentsDataSource: ApiCommentDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<ConnexionBloc>(
              create: (context) => ConnexionBloc(),
            ),
            BlocProvider<InscriptionBloc>(
              create: (context) => InscriptionBloc(),
            ),
            BlocProvider<PostBloc>(
              create: (context) => PostBloc(
                postsRepository: context.read<PostsRepository>(),
              ),
            ),
            BlocProvider<PostGetBloc>(
              create: (context) => PostGetBloc(
                postsRepository: context.read<PostsRepository>(),
              ),
            ),
            BlocProvider<PostDeleteBloc>(
              create: (context) => PostDeleteBloc(
                postsRepository: context.read<PostsRepository>(),
              ),
            ),
            BlocProvider<PostPatchBloc>(
              create: (context) => PostPatchBloc(
                postsRepository: context.read<PostsRepository>(),
              ),
            ),
            BlocProvider<GetCommentBloc>(
              create: (context) => GetCommentBloc(
                commentsRepository: context.read<CommentsRepository>(),
              ),
            ),
            BlocProvider<CommentPatchBloc>(
              create: (context) => CommentPatchBloc(),
            ),
            BlocProvider<CommentDeleteBloc>(
              create: (context) => CommentDeleteBloc(
                commentsRepository: context.read<CommentsRepository>(),
              ),
            ),
            BlocProvider<CommentPostBloc>(
              create: (context) => CommentPostBloc(),
            ),
          ],
          child: MaterialApp.router(
            title: 'Flitter',
            routerConfig: router,
          )),
    );
  }
}
