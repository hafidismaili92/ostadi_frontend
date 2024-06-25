

import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/posts_repository.dart';

class LoadPosts
  
{
  final PostsRepository repository;

  LoadPosts({required this.repository});
  
  Future<Either<Failure,List<Post>>> getPosts() async {

      final result = await repository.loadPosts();
      return result;
  }
}

