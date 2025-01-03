import 'package:bloc/bloc.dart';
import 'package:clinikk/features/home/repos/post_repos.dart';
import 'package:clinikk/features/home/static/models/post_model.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> search(int query) async {
    emit(SearchLoading());
    try {
      final posts = await PostRepos.findPost(id: query);
      emit(
        SearchLoaded(
          post: posts,
        ),
      );
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
