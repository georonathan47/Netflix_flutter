import '../../domain/entities/netflix.dart';
import '../models/NetflixModel.dart';

abstract class NetflixLocaleDS{
  Future<NetflixEntity>? cacheMovie(NetflixModel movie);
  Future<NetflixEntity>? getLastNetflixMovie();

}