import 'package:equatable/equatable.dart';
import '../post.dart';

class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostLoadSuccess extends PostState {
  final List<Post> posts;

  PostLoadSuccess([this.posts = const []]);

  @override
  List<Object> get props => [posts];
}

class StationPostsLoadSuccess extends PostState {
  final List<Post> stationPosts;

  StationPostsLoadSuccess([this.stationPosts = const []]);

  @override
  List<Object> get props => [stationPosts];
}

class PostOperationFailure extends PostState {
  final String message;
  PostOperationFailure({this.message});
  @override
  List<Object> get props => [message];
}
