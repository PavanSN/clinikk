import 'package:bloc/bloc.dart';
import 'package:clinikk/features/home/repos/post_repos.dart';
import 'package:clinikk/features/home/static/models/post_model.dart';
import 'package:meta/meta.dart';

part 'post_cubit_state.dart';

class PostCubit extends Cubit<PostCubitState> {
  PostCubit() : super(PostCubitInitial());

  Future<void> getPost() async {
    try {
      emit(PostCubitLoading());
      final posts = await PostRepos.getPosts();
      emit(PostCubitLoaded(post: posts??[]));
    } catch (e) {
      emit(PostCubitError(message: e.toString()));
    }
  }
}
