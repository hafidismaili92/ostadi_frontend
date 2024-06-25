import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

abstract class PostsRepository {

  Future<Either<Failure,List<Post>>> loadMyPosts();
  Future<Either<Failure,List<Post>>> loadPosts();
  Future<Either<Failure,Post>> addNewPost(PostParams postParams);
}

