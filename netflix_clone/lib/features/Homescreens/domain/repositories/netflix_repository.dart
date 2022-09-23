import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failures.dart';
import 'package:netflix_clone/features/Homescreens/domain/entities/netflix.dart';

abstract class NetflixRepository {
  Future<Either<Failures, NetflixEntity?>>? getConcreteNetflixMovie(String? title); //
  Future<Either<Failures, NetflixEntity>>? getLatestNetflixMovie(); //
  Future<Either<Failures, NetflixEntity>>? getPopularNetflixMovies(); //
  Future<Either<Failures, NetflixEntity>>? getTopRatedNetflixMovies(); //
  Future<Either<Failures, NetflixEntity>>? getNowPlayingNetflixMovies();
  // Future<Either<Failures, NetflixEntity>>? getUpcomingMNetflixovies();

}