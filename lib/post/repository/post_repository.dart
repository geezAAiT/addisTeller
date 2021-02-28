import 'package:meta/meta.dart';
import '../post.dart';

class PostRepository {
  final PostDataProvider postProvider;

  PostRepository({@required this.postProvider}) : assert(postProvider != null);

  Future<Post> createPost(Post post, String StationID) async {
    return await postProvider.createPost(post, StationID);
  }

  Future<List<Post>> getPosts() async {
    return await postProvider.getPosts();
  }

  Future<List<Post>> getStationPosts(String stationID) async {
    return await postProvider.getPostByStationID(stationID);
  }

  Future<void> deletePost(String id) async {
    await postProvider.deletePost(id);
  }

  Future<void> updatePost(Post post) async {
    await postProvider.updatePost(post);
  }
}
