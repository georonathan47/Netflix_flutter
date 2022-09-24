import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/network_info.dart';
import '../../domain/entities/netflix.dart';
import '../../domain/repositories/netflix_repository.dart';
import '../datasources/netflix_localDS.dart';
import '../datasources/netflix_remote_DS.dart';

class NetflixRepoImpl implements NetflixRepository {
  final NetworkInfo? networkInfo;
  final NetflixRemoteDS? remoteDataSource;
  final NetflixLocaleDS localeDataSource;

  NetflixRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localeDataSource,
  });

  @override
  Future<Either<Failures, NetflixEntity>> getConcreteNetflixMovie(
    String? title,
  ) async {
    if (await networkInfo!.isConnected!) {
      try {
        final remoteMovie = await remoteDataSource!.getConcreteNetflixMovie(title);
        localeDataSource.cacheMovie(remoteMovie!);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try{
        final localMovie = await localeDataSource.getLastNetflixMovie();
        return Right(localMovie!);
      } on CacheException {
        return Left(CacheFailure());
      }

    }
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
