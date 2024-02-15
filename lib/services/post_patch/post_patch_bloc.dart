import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/write_post.dart';
import '../repository/posts/posts_repository.dart';

part 'post_patch_event.dart';

part 'post_patch_state.dart';

class PostPatchBloc extends Bloc<PostPatchEvent, PostPatchState> {
  final _storage = const FlutterSecureStorage();

  final PostsRepository postsRepository;

  PostPatchBloc({required this.postsRepository}) : super(PostPatchState()) {
    on<PostPatch>(_onPostPatchEvent);
  }

  void _onPostPatchEvent(PostPatch event, Emitter<PostPatchState> emit) async {
    try {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        emit(state.copyWith(status: PostPatchStatus.loading));
        await postsRepository.patchPost(event.post, token, event.id);
        emit(state.copyWith(
          status: PostPatchStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: PostPatchStatus.error,
          error: 'Vous devez être connecté pour modifier un post',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: PostPatchStatus.error,
        error: error,
      ));
    }
  }
}
