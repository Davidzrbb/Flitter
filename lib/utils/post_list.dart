import 'package:flitter/models/get_post.dart';
import 'package:flitter/utils/tile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/post_get_bloc/post_get_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ScrollController _controller = ScrollController();

  List<Item> allItem = <Item>[];
  bool hasMore = true;
  int page = 1;
  final limit = 12;

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
    initializeDateFormatting('fr_FR', null);
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
                allItem.addAll(
                    posts.items.where((element) => !allItem.contains(element)));
              }
              if (posts != null && posts.items.isEmpty) {
                hasMore = false;
              }
              return ListView.separated(
                controller: _controller,
                itemCount: allItem.length + 1,
                separatorBuilder: (context, _) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                itemBuilder: (context, index) {
                  if (index < allItem.length) {
                    final item = allItem[index];
                    return TilePost(
                      item: item,
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

  Future<void> refresh() async {
    setState(() {
      page = 1;
      allItem.clear();
    });
  }

  getAll() {
    setState(() {
      final productsBloc = BlocProvider.of<PostGetBloc>(context);
      productsBloc.add(PostGetAll(page, limit));
      page += 1;
    });
  }
}
