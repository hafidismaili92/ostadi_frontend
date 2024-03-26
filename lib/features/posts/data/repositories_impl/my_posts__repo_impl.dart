import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/my_posts_repository.dart';

class  MyPostsRepositoryImpl implements MyPostsRepository {

final MyPostsRemoteDataSource remoteDataSource;
final TokenRepository tokenRepo;

MyPostsRepositoryImpl({required this.tokenRepo,required this.remoteDataSource});
@override
Future<Either<Failure,List<Post>>> loadMyPosts() async
{
  try {
    final token = await tokenRepo.readToken();
    if(token != null)
    {

  final result = await remoteDataSource.loadMyPosts(token);
  return Right(result);
  }
   return Left(NoTokenRegistredFailure());
}
on ServerException
{
  return Left(ServerFailure());
}
on NoConnectionException
{
  return Left(ConnectionFailure());
}
 on Exception catch (e) {
  return Left(UnknownFailure());
}
}

}