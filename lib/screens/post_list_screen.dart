import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/post_get_bloc/post_get_bloc.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  void initState() {
    super.initState();
    final productsBloc = BlocProvider.of<PostGetBloc>(context);
    productsBloc.add(PostGetAll(null, null));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: BlocBuilder<PostGetBloc, PostGetState>(
        builder: (context, state) {
          switch (state.status) {
            case PostGetStatus.initial:
              return const SizedBox();
            case PostGetStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostGetStatus.error:
              return Center(
                child: Text(state.error.toString() ?? ''),
              );
            case PostGetStatus.success:
              final posts = state.posts;
              return ListView.separated(
                itemCount: posts!.itemsReceived,
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final post = posts.items[index];
                  return ListTile(
                    title: Text(post.author.name),
                    subtitle: Text(post.content),
                  );
                },
              );
          }
        },
      ),
    );
  }

  Future refresh() async {
    // Your refresh logic goes here
  }
}
