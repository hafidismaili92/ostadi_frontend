
import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/posts_repository.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

class AddJobPostUseCase
{
  final PostsRepository repository;

  AddJobPostUseCase({required this.repository});
  Future<Either<Failure,Post>> execute(PostParams postParams) async {

    final result = await repository.addNewPost(postParams);
    return result;

  }
  
}