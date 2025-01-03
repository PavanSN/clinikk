part of 'post_cubit_cubit.dart';

@immutable
sealed class PostCubitState {}

final class PostCubitInitial extends PostCubitState {}

final class PostCubitLoading extends PostCubitState {}

final class PostCubitLoaded extends PostCubitState {

  PostCubitLoaded({required this.post});
  final List<Post> post;
}

final class PostCubitError extends PostCubitState {

  PostCubitError({required this.message});
  final String message;
}
