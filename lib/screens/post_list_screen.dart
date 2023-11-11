import 'package:flitter/models/get_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_avatar/random_avatar.dart';

import '../services/post_get_bloc/post_get_bloc.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ScrollController _controller = ScrollController();
  List<Item> allItem = <Item>[];
  final List<Widget> _painters = <Widget>[];
  bool hasMore = true;
  int page = 1;

  @override
  void initState() {
    super.initState();
    getAll();
    _controller.addListener(() {
      if (_controller.offset == _controller.position.maxScrollExtent) {
        getAll();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            case PostGetStatus.error:
              return Center(
                child: Text(state.error.toString()),
              );
            case PostGetStatus.success:
              final posts = state.posts;
              if (posts != null && posts.items.isNotEmpty) {
                allItem.addAll(posts.items);
              }
              return ListView.separated(
                controller: _controller,
                itemCount: allItem.length + 1,
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  if (index < allItem.length) {
                    final item = allItem[index];
                    String svg = RandomAvatarString(item.author.id.toString(),
                        trBackground: true);
                    _painters.add(
                      RandomAvatar(
                        svg,
                        height: 50,
                        width: 52,
                      ),
                    );
                    return ListTile(
                      leading: _painters[index],
                      title: Text(item.author.name),
                      subtitle: Text(item.content),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(
                        child: hasMore
                            ? const CircularProgressIndicator()
                            : const Text('Il n y a plus de posts !'),
                      ),
                    );
                  }
                },
              );
          }
        },
      ),
    );
  }

  Future refresh() async {
    setState(() {
      page = 1;
      allItem.clear();
      getAll();
    });
  }

  getAll() {
    const limit = 12;
    final productsBloc = BlocProvider.of<PostGetBloc>(context);
    productsBloc.add(PostGetAll(page, limit));
    setState(() {
      page++;
      if (allItem.length < page * limit) {
        hasMore = true;
      } else {
        hasMore = false;
      }
    });
  }
}
