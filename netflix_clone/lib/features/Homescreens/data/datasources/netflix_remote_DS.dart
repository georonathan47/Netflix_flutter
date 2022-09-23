import 'package:netflix_clone/features/Homescreens/data/models/NetflixModel.dart';

abstract class NetflixRemoteDS {
  /// Calls the https://api.themoviedb.org/3/movie/find/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NetflixModel>? getConcreteNetflixMovie(String? title);
  Future<NetflixModel> getLatestNetflixMovie();
  Future<NetflixModel> getTopRatedNetflixMovies();
  Future<NetflixModel> getNowPlayingNetflixMovies();
  Future<NetflixModel> getPopularNetflixMovies();
}
