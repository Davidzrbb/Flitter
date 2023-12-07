import 'package:bloc/bloc.dart';
import 'package:flitter/models/get_post.dart';
import '../repository/posts/posts_repository.dart';

part 'post_get_event.dart';

part 'post_get_state.dart';

class PostGetBloc extends Bloc<PostGetEvent, PostGetState> {
  final PostsRepository postsRepository;

  PostGetBloc({required this.postsRepository}) : super(PostGetState()) {
    on<PostGetAll>(_onPostGetAll);
  }

  void _onPostGetAll(PostGetAll event, Emitter<PostGetState> emit) async {
    try {
      int page = 1;
      GetPost posts;
      List<Item> allItem = [];

      if (event.refresh) {
        emit(state.copyWith(status: PostGetStatus.loading));
        posts = await postsRepository.getAllProducts(page, state.perPage);
        allItem = posts.items;
      } else {
        page = state.page != null ? state.page! + 1 : page;
        posts = await postsRepository.getAllProducts(page, state.perPage);
        allItem = state.items ?? [];
        allItem.addAll(posts.items
            .where((item) => !allItem.any((element) => element.id == item.id)));
      }

      bool hasMore = posts.nextPage != null;

      emit(state.copyWith(
        status: PostGetStatus.success,
        posts: posts,
        items: allItem,
        page: page,
        perPage: state.perPage,
        hasMore: hasMore,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostGetStatus.error,
        error: error,
      ));
    }
  }
}
