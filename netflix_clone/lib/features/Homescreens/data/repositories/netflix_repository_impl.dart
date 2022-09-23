import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/exceptions.dart';
import 'package:netflix_clone/core/errors/failures.dart';
import 'package:netflix_clone/core/services/network_info.dart';
import 'package:netflix_clone/features/Homescreens/data/datasources/netflix_remote_DS.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';
import 'package:netflix_clone/features/Homescreens/domain/repositories/netflix_repository.dart';

class NetflixRepoImpl implements NetflixRepository {
  final NetworkInfo? networkInfo;
  final NetflixRemoteDS? remoteDataSource;

  NetflixRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failures, NetflixEntity?>> getConcreteNetflixMovie(
    String? title,
  ) async {
    // if (await networkInfo!.isConnected!) {
      try {
        final remoteMovie = await remoteDataSource!.getConcreteNetflixMovie(title!);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    // } else {
      // return Left(ServerFailure());
    // }
  }

  @override
  Future<Either<Failures, NetflixEntity>>? getLatestNetflixMovie() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, NetflixEntity>>? getNowPlayingNetflixMovies() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, NetflixEntity>>? getPopularNetflixMovies() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, NetflixEntity>>? getTopRatedNetflixMovies() {
    throw UnimplementedError();
  }
}
