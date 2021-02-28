import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({@required this.postRepository})
      : assert(postRepository != null),
        super(PostLoading());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostLoad) {
      yield PostLoading();
      try {
        final posts = await postRepository.getPosts();
        yield PostLoadSuccess(posts);
      } catch (e) {
        yield PostOperationFailure(message: "$e");
      }
    }
    if (event is StationPostLoad) {
      yield PostLoading();
      try {
        final posts = await postRepository.getStationPosts(event.stationID);
        yield StationPostsLoadSuccess(posts);
      } catch (e) {
        yield PostOperationFailure(message: "$e");
      }
    }

    if (event is PostCreate) {
      try {
        await postRepository.createPost(event.post, event.stationID);
        final posts = await postRepository.getPosts();
        yield StationPostsLoadSuccess(posts);
        // yield PostLoadSuccess(posts);
      } catch (e) {
        yield PostOperationFailure(message: "$e");
      }
    }

    if (event is PostUpdate) {
      try {
        await postRepository.updatePost(event.post);
        final posts = await postRepository.getPosts();
        yield PostLoadSuccess(posts);
      } catch (e) {
        yield PostOperationFailure(message: "$e");
      }
    }

    if (event is PostDelete) {
      try {
        await postRepository.deletePost(event.post.id);
        final posts = await postRepository.getStationPosts(event.stationID);
        yield StationPostsLoadSuccess(posts);
      } catch (e) {
        yield PostOperationFailure(message: "$e");
      }
    }
  }
}
