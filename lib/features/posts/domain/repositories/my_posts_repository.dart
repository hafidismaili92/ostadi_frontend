import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';

abstract class MyPostsRepository {

  Future<Either<Failure,List<Post>>> loadMyPosts();

}

