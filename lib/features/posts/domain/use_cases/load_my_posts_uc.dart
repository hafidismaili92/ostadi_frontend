

import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/my_posts_repository.dart';

class LoadMyPosts
  
{
  final MyPostsRepository repository;

  LoadMyPosts({required this.repository});
  
  Future<Either<Failure,List<Post>>> getMyPosts() async {

      final result = await repository.loadMyPosts();
      return result;
  }
}

