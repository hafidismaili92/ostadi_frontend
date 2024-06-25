import 'package:dartz/dartz.dart';
import 'package:ostadi_frontend/core/errors/exception.dart';
import 'package:ostadi_frontend/core/errors/failure.dart';
import 'package:ostadi_frontend/features/auth/data/repositories_impl/token_repository.dart';
import 'package:ostadi_frontend/features/posts/data/data_sources/my_posts_remote_datasource.dart';
import 'package:ostadi_frontend/features/posts/domain/entities/post.dart';
import 'package:ostadi_frontend/features/posts/domain/repositories/posts_repository.dart';
import 'package:ostadi_frontend/features/posts/utils/classes/post_params.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  final TokenRepository tokenRepo;

  PostsRepositoryImpl(
      {required this.tokenRepo, required this.remoteDataSource});
  @override
  Future<Either<Failure, List<Post>>> loadMyPosts() async {
    try {
      final token = await tokenRepo.readToken();
      if (token != null) {
        final result = await remoteDataSource.loadMyPosts(token);
        return Right(result);
      }
      return Left(NoTokenRegistredFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on NoConnectionException {
      return Left(ConnectionFailure());
    } on Exception catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> loadPosts() async {
    try {
      final token = await tokenRepo.readToken();
      if (token != null) {
        final result = await remoteDataSource.loadPosts(token);
        return Right(result);
      }
      return Left(NoTokenRegistredFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on NoConnectionException {
      return Left(ConnectionFailure());
    } on Exception catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> addNewPost(PostParams postParams) async {
    try {
      final token = await tokenRepo.readToken();
      
      if (token != null) {
        final result = await remoteDataSource.addNewPost(postParams,token);
        return Right(result);
      }
      return Left(NoTokenRegistredFailure());
      
    } on ServerException {
      return Left(ServerFailure());
    } on NoConnectionException {
      return Left(ConnectionFailure());
    } on Exception catch (e) {
      return Left(UnknownFailure());
    }
  }
}
