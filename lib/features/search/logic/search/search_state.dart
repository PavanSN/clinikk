part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  SearchLoaded({required this.post});
  final List<Post>? post;
}

final class SearchError extends SearchState {

  SearchError({required this.message});
  final String message;
}
