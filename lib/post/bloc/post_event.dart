import 'package:equatable/equatable.dart';
import '../post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostLoad extends PostEvent {
  const PostLoad();

  @override
  List<Object> get props => [];
}

class StationPostLoad extends PostEvent {
  const StationPostLoad({this.stationID});
  final String stationID;
  @override
  List<Object> get props => [stationID];
}

class PostCreate extends PostEvent {
  final Post post;
  final String stationID;
  const PostCreate(this.post, this.stationID);

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'Post Created {post: $post}';
}

class PostUpdate extends PostEvent {
  final Post post;
  final String stationID;
  const PostUpdate(this.post, this.stationID);

  @override
  List<Object> get props => [post,stationID];

  @override
  String toString() => 'Post Updated {post: $post}';
}

class StationPostDelete extends PostEvent {
  final Post post;
  final String stationID;
  const StationPostDelete({this.post, this.stationID});

  @override
  List<Object> get props => [post, stationID];

  @override
  toString() => 'Post Deleted {post: $post}';
}

class PostDelete extends PostEvent {
  final Post post;
  const PostDelete({this.post});

  @override
  List<Object> get props => [post];

  @override
  toString() => 'Post Deleted {post: $post}';
}
