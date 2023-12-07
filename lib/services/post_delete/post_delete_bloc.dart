import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repository/posts/posts_repository.dart';

part 'post_delete_event.dart';

part 'post_delete_state.dart';

class PostDeleteBloc extends Bloc<PostDeleteEvent, PostDeleteState> {
  final _storage = const FlutterSecureStorage();

  final PostsRepository postsRepository;

  PostDeleteBloc({required this.postsRepository}) : super(PostDeleteState()) {
    on<PostDelete>(_onPostDelete);
  }

  void _onPostDelete(PostDelete event, Emitter<PostDeleteState> emit) async {
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        await postsRepository.deletePost(event.id.toString(), token);
        emit(state.copyWith(
          status: PostDeleteStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: PostDeleteStatus.error,
          error: 'Vous devez être connecté pour supprimer un post',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: PostDeleteStatus.error,
        error: error,
      ));
    }
  }
}
